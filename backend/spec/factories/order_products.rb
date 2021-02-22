FactoryBot.define do

  factory :order_product do
    association :product
    association :order
    association :price
    sub_total { 49.99 }
    quantity { 1 }
  end
end

