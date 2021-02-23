# frozen_string_literal: true

class Product < ApplicationRecord
  include UuidGenerator

  mount_uploader :image, ProductImageUploader

  has_many :prices
  has_one :stock

  validates :name, :description, presence: true
  validates :name, uniqueness: true

  MAGIC_POTION = 'Magic Potion'

  scope :find_magic_potion!, -> { find_by!(name: MAGIC_POTION) }

  def as_json(_options = {})
    {
      uuid: uuid,
      name: name,
      description: description,
      price: prices.last.price.to_d,
      imageUrl: image.url,
      orderLimit: order_limit
    }
  end
end
