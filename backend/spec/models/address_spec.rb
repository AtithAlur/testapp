# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:address_line1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }

    it { should validate_uniqueness_of(:address_line1) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
