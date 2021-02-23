# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:total) }

    it { 
      should define_enum_for(:status)
        .with_values(
          pending: 'pending',
          fulfilled: 'fulfilled',
          delivered: 'delivered',
          cancelled: 'cancelled'
      ).backed_by_column_of_type(:enum)
    }

    it 'throws error if the ordered product exceed the limit and the total is invalid' do
      expect {
        order_product = FactoryBot.create(:order_product, quantity: 10)
        FactoryBot.create(:order, order_products: [order_product])
      }.to raise_error('Validation failed: User crossed the order limit: 3, Total Expected total is: 99.98, actual: 49.99')
    end
  end

  describe 'associations' do
    it { should have_many(:order_products) }
    it { should belong_to(:user) }
    it { should belong_to(:address) }
    it { should belong_to(:credit_card) }
  end
end
