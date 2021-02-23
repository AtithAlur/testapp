# frozen_string_literal: true

class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product
  belongs_to :price

  validates :product, :order, :price, :quantity, :sub_total, presence: true
  validates :product_id, uniqueness: { scope: :order_id }
  validates :quantity, :sub_total, numericality: { greater_than: 0 }

  def self.build_products(products)
    products.map do |product_attrs|
      product = Product.find_by(uuid: product_attrs[:uuid])
      price = Price.where(product: product).last
      price_val = price.present? ? price.price : 0
      sub_total = price_val * product_attrs[:quantity].to_i
      OrderProduct.new(product: product, price: price,
                       sub_total: sub_total, quantity: product_attrs[:quantity])
    end
  end
end
