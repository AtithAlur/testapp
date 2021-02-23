# frozen_string_literal: true

class CreditCard < ApplicationRecord
  include UuidGenerator

  belongs_to :user

  validates :card_number, presence: true, uniqueness: { scope: :user_id }
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
    return if expiry.nil?

    date = begin
      Date.strptime(expiry, '%m/%Y')
    rescue StandardError
      nil
    end
    errors.add(:expiry, :invalid, message: 'is invalid!') && return if date.blank?

    errors.add(:expiry, :expired, message: 'card is expired!') if date < Time.now
  end

  def validate_card_number_length
    return if card_number.nil?
    return if card_number.length == 16 || card_number.length == 20

    errors.add(:card_number, :invalid_length,
               message: 'should be either 16 or 20 digits.')
  end
end
