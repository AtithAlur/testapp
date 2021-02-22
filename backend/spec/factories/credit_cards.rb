FactoryBot.define do

  factory :credit_card do
    user
    card_number { Faker::Number.number(digits: 16).to_s }
    expiry { '08/2021' }
  end
end


