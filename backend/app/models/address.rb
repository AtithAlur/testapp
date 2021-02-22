# frozen_string_literal: true

class Address < ApplicationRecord
  include UuidGenerator

  belongs_to :user

  validates :address_line1, :city, :state, :zip, presence: true

  def as_json(_options = {})
    {
      street1: address_line1,
      street2: address_line2,
      city: city,
      state: state,
      zip: zip
    }
  end
end
