# frozen_string_literal: true

class Price < ApplicationRecord
  belongs_to :product

  has_many :order_products
end
