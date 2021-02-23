# frozen_string_literal: true

class Stock < ApplicationRecord
  belongs_to :product

  validates :product, :quantity, presence: true
end
