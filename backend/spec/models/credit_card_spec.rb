# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:card_number) }
    it { should validate_presence_of(:expiry) }

    it { should validate_uniqueness_of(:card_number) }

    it { should validate_length_of(:expiry).is_equal_to(7) }

    it 'does not allow credit card of length other than 16 and 20' do
      expect {
        FactoryBot.create(:credit_card, card_number: '9'*20)
      }.to_not raise_error

      expect {
        FactoryBot.create(:credit_card, card_number: '9'*16)
      }.to_not raise_error

      expect {
        FactoryBot.create(:credit_card, card_number: '9'*12)
      }.to raise_error('Validation failed: Card number should be either 16 or 20 digits.')
    end

    it 'throws error if the card is expired' do
      expect {
        FactoryBot.create(:credit_card, expiry: '01/2021')
      }.to raise_error('Validation failed: Expiry card is expired!')
    end

    it 'throws error if the format is invalid' do
      expect {
        FactoryBot.create(:credit_card, expiry: '0102021')
      }.to raise_error('Validation failed: Expiry is invalid!')
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
