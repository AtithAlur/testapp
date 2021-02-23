# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderProduct, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:product) }
    it { should validate_presence_of(:order) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:sub_total) }

    it { should validate_uniqueness_of(:product_id).scoped_to(:order_id) }
    it { should validate_numericality_of(:quantity).is_greater_than(0) }
    it { should validate_numericality_of(:sub_total).is_greater_than(0) }
  end

  describe 'associations' do
    it { should belong_to(:order) }
    it { should belong_to(:product) }
    it { should belong_to(:price) }
  end

  describe '.build_products' do
    let(:product) { FactoryBot.create(:product) }
    let(:params) do
      [{
        uuid: product.uuid,
        quantity: 10
      }]
    end

    it 'returns order products' do
      expect {
        order_products = described_class.build_products(params)

        order_products.each do|op|
          expect(op.product).to be_present
          expect(op.price).to be_present
          expect(op.sub_total.to_d).to eq(499.9)
          expect(op.quantity).to eq(10)
        end
      }.to_not change{ OrderProduct.count }
    end

    it 'does not throw error is price does not exist' do
      expect {
        product.prices.destroy_all
        described_class.build_products(params)
      }.to_not raise_error
    end
  end
end
