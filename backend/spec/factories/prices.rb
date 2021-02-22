FactoryBot.define do

  factory :price do
    product { FactoryBot.create(:product) }
    price { 49.99 }
  end
end

