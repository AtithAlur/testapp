# frozen_string_literal: true

class Price < ApplicationRecord
  belongs_to :product

  has_many :order_products

  validates :product, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
end
