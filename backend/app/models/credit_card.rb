# frozen_string_literal: true

class CreditCard < ApplicationRecord
  include UuidGenerator

  belongs_to :user

  validates :card_number, presence: true, uniqueness: true
  validates :expiry, presence: true, length: { is: 7 }

  validate :validate_card_number_length, :validate_expiry

  def as_json(_options = {})
    {
      "ccNum": card_number,
      "exp": expiry
    }
  end

  private

  def validate_expiry
    errors.add(:expiry, :expired, message: 'Card is expired!') if Date.strptime(expiry, '%d/%Y') < Time.now
  end

  def validate_card_number_length
    return if card_number.length == 16 || card_number.length == 20

    errors.add(:card_number, :invalid_length,
               message: 'Credit number should be either 16 or 20 digits.')
  end
end
