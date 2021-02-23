# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Price, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:product) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
  end

  describe 'associations' do
    it { should have_many(:order_products) }
    it { should belong_to(:product) }
  end
end
