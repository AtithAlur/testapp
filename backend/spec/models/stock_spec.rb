# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:product) }
    it { should validate_presence_of(:quantity) }
  end

  describe 'associations' do
    it { should belong_to(:product) }
  end
end
