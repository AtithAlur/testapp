# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone_number) }

    it { should validate_uniqueness_of(:email) }
  end

  describe 'associations' do
    it { should have_many(:orders) }
    it { should have_many(:credit_cards) }
    it { should have_many(:addresses) }
  end
end
