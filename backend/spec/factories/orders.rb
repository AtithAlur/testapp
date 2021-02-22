FactoryBot.define do
  factory :order do
    association :user
    association :address
    association :credit_card
    status { 'pending' }
    total { 20.0 }

    before :create do|order|
      product = FactoryBot.create(:product)
      price = product.prices.last
      op = FactoryBot.build(:order_product, product: product, price: price)
      order.order_products << op
      order.total = '49.99'
    end
  end
end
