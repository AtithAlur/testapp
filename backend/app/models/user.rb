# frozen_string_literal: true

class User < ApplicationRecord
  include UuidGenerator

  has_many :orders
  has_many :credit_cards
  has_many :addresses

  validates :first_name, :last_name, :email, :phone_number, presence: true
  validates :email, uniqueness: true
  validates_associated :orders

  def self.create_user!(attrs)
    sanitize_values!(attrs)
    User.create!(attrs)
  end

  def self.find_or_initialize_address(user, address_attrs)
    p '///////'
    p address_attrs[:address_line1]
    p address = user.addresses.find_by(address_line1: address_attrs[:address_line1])
    return address if address.present?

    Address.new(address_attrs.merge(user: user))
  end

  def self.find_or_initialize_credit_card(user, credit_card_attrs)
    card = user.credit_cards.find_by(card_number: credit_card_attrs[:card_number])
    return card if card.present?

    CreditCard.new(credit_card_attrs.merge(user: user))
  end

  def self.sanitize_values!(attrs)
    attrs[:phone_number] = sanitize_phone_number(attrs[:phone_number])
  end

  def self.sanitize_phone_number(phone_number)
    phone_number.gsub(/-/, '')
  end
end
