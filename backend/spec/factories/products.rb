FactoryBot.define do

  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    order_limit { 3 }
    image { File.open(Rails.root.join('public', 'magic_potion.png')) }

    after :create do |product|
      create_list :price, 2, product: product
    end
  end
end
