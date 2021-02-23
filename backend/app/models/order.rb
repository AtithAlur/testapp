# frozen_string_literal: true

class Order < ApplicationRecord
  include UuidGenerator

  enum status: {
    pending: 'pending',
    fulfilled: 'fulfilled',
    delivered: 'delivered',
    cancelled: 'cancelled'
  }

  belongs_to :user
  belongs_to :address
  belongs_to :credit_card

  has_many :order_products
  has_many :products, through: :order_products

  validates :user, :status, :total, presence: true
  validates :status, inclusion: { in: statuses.keys }
  validates_associated :address, :credit_card

  validate :validate_order_limits, :validate_total, on: :create

  def self.create_order!(user, attrs)
    address_attrs = attrs.delete(:address)
    credit_card_attrs = attrs.delete(:credit_card)
    product_attrs = attrs[:products]

    p address = User.find_or_initialize_address(user, address_attrs)
    credit_card = User.find_or_initialize_credit_card(user, credit_card_attrs)
    order_products = OrderProduct.build_products(product_attrs)

    Order.create!(user: user, status: :pending, order_products: order_products,
                  total: attrs[:total], address: address, credit_card: credit_card)
  end

  def self.update_order!(order, attrs)
    return if attrs[:fulfilled].blank?

    order.fulfilled! if attrs[:fulfilled] == 'true'
    order.pending! if attrs[:fulfilled] == 'false'
  end

  # rubocop:disable Metrics/AbcSize
  def as_json(_options = {})
    quantity = order_products.flat_map(&:quantity).sum
    {
      firstName: user.first_name, lastName: user.last_name,
      email: user.email, phone: user.phone_number,
      address: address, payment: credit_card,
      quantity: quantity, total: total,
      orderDate: created_at.utc.to_s, fulfilled: fulfilled?
    }
  end
  # rubocop:enable Metrics/AbcSize

  private

  def validate_total
    expected_total = order_products.map(&:sub_total).sum
    return if total.to_d == expected_total.to_d

    errors.add(:total, :invalid_value, message: "Expected total is: #{expected_total}, actual: #{total}")
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def validate_order_limits
    uuids = order_products.map { |op| op.product.uuid }
    previous_prods = prev_order_products(user, uuids)
    order_products.each do |order_product|
      product = order_product.product
      prev_count = previous_prods[product.uuid].present? ? previous_prods[product.uuid].map(&:quantity).sum : 0
      new_quantity = prev_count + order_product.quantity
      next unless new_quantity > product.order_limit

      error_message = "User crossed the order limit: #{product.order_limit}"
      Rails.logger.error(error_message)
      errors.add(:base, :invalid_order, message: error_message)
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def prev_order_products(user, uuids)
    Order.includes(%i[order_products products])
         .where(user: user, products: { uuid: uuids })
         .flat_map(&:order_products)
         .group_by { |op| op.product.uuid }
  end
end
