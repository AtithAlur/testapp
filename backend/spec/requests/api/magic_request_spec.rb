# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Magic', type: :request do
  describe '#create' do
    let!(:magic_potion) do
      FactoryBot.create(:product, name: Product::MAGIC_POTION)
    end
    let(:request) do
      {
        firstName: Faker::Name.first_name,
        lastName: Faker::Name.last_name,
        email: Faker::Internet.email,
        address: {
          street1: Faker::Address.street_address,
          street2: Faker::Address.secondary_address,
          city: Faker::Address.city,
          state: Faker::Address.state_abbr,
          zip: Faker::Address.zip
        },
        phone: Faker::Base.numerify('###-###-####'),
        quantity: 2,
        total: '99.98',
        payment: {
          ccNum: Faker::Number.number(digits: 16).to_s,
          exp: '08/2021'
        }
      }
    end

    it 'creates a new order' do
      post '/api/magic', params: request

      response_body = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(response_body['uid']).to be_present
    end

    it 'accepts multiple orders from a same user' do
      request[:quantity] = 1
      request[:total] = '49.99'
      post '/api/magic', params: request

      expect(response).to have_http_status(:created)

      request[:quantity] = 2
      request[:total] = '99.98'
      post '/api/magic', params: request

      expect(response).to have_http_status(:created)

      user = User.find_by(email: request[:email])
      expect(user.orders.count).to eq(2)
      order_products = user.orders.flat_map(&:order_products)
      expect(order_products.map(&:quantity).sum).to eq(3)
    end

    it 'does not create duplicate credit cards and addresses for multiple orders' do
      request[:quantity] = 1
      request[:total] = '49.99'
      post '/api/magic', params: request

      expect(response).to have_http_status(:created)

      request[:quantity] = 2
      request[:total] = '99.98'
      post '/api/magic', params: request

      expect(response).to have_http_status(:created)

      user = User.find_by(email: request[:email])
      expect(user.credit_cards.count).to eq(1)
      expect(user.addresses.count).to eq(1)
    end

    it 'does not create orders if the total is wrong' do
      request[:quantity] = 1
      request[:total] = '20'
      post '/api/magic', params: request

      expect(response).to have_http_status(:unprocessable_entity)
      response_body = JSON.parse(response.body)
      expect(response_body['message'])
        .to eq('Validation failed: Total Expected total is: 49.99, actual: 20.0')
    end

    it 'does not create orders if quantity exceeds the order limit' do
      request[:quantity] = 4
      request[:total] = '199.96'
      post '/api/magic', params: request

      expect(response).to have_http_status(:unprocessable_entity)
      response_body = JSON.parse(response.body)
      expect(response_body['message'])
        .to eq('Validation failed: User crossed the order limit: 3')
    end

    it 'does not accept a new order if a user has exceeded the limit' do
      request[:quantity] = 2
      request[:total] = '99.98'
      post '/api/magic', params: request

      expect(response).to have_http_status(:created)

      request[:quantity] = 2
      request[:total] = '99.98'
      post '/api/magic', params: request

      expect(response).to have_http_status(:unprocessable_entity)
      response_body = JSON.parse(response.body)
      expect(response_body['message'])
        .to eq('Validation failed: User crossed the order limit: 3')
    end
  end

  describe '#show' do
    let(:address) { FactoryBot.create(:address) }
    let(:credit_card) { FactoryBot.create(:credit_card) }
    let(:user) { FactoryBot.create(:user) }
    let(:order) do
      FactoryBot.create(:order, user: user, address: address,
                        credit_card: credit_card)
    end
    let(:expected_order_details) do
      {
        'firstName' => user.first_name,
        'lastName' => user.last_name,
        'email' => user.email,
        'address' => {
          'street1' => address.address_line1,
          'street2' => address.address_line2,
          'city' => address.city,
          'state' => address.state,
          'zip' => address.zip
        },
        'phone' => user.phone_number,
        'payment' => {
          'ccNum' => credit_card.card_number,
          'exp' => credit_card.expiry
        },
        'quantity' => 1,
        'total' => "49.99",
        'orderDate' => order.created_at.utc.to_s,
        'fulfilled' => false
      }
    end

    it 'returns the order' do
      get "/api/magic/#{order.uuid}"

      expect(response).to have_http_status(:ok)
      response_body = JSON.parse(response.body)
      expect(response_body).to eq(expected_order_details)
    end

    it 'returns 404 if the order does not exist' do
      get "/api/magic/123"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe '#update' do
    let(:address) { FactoryBot.create(:address) }
    let(:credit_card) { FactoryBot.create(:credit_card) }
    let(:user) { FactoryBot.create(:user) }
    let(:order) do
      FactoryBot.create(:order, user: user, address: address,
                        credit_card: credit_card)
    end

    let(:request_body) do
      {
        uid: order.uuid,
        fulfilled: true
      }
    end

    it 'updates the order to fulfilled' do
      patch "/api/magic", params: request_body

      expect(response).to have_http_status(:no_content)
      order.reload
      expect(order).to be_fulfilled
    end

    it 'reverts the order to pending if fulfilled is false' do
      patch "/api/magic", params: request_body

      expect(response).to have_http_status(:no_content)
      order.reload
      expect(order).to be_fulfilled

      request_body[:fulfilled] = false
      patch "/api/magic", params: request_body

      expect(response).to have_http_status(:no_content)
      order.reload
      expect(order).to be_pending
    end

    it 'returns 404 if the order does not exist' do
      request_body[:uid] = '123'
      patch "/api/magic", params: request_body

      expect(response).to have_http_status(:not_found)
    end
  end

  describe '#delete' do
    let(:address) { FactoryBot.create(:address) }
    let(:credit_card) { FactoryBot.create(:credit_card) }
    let(:user) { FactoryBot.create(:user) }
    let(:order) do
      FactoryBot.create(:order, user: user, address: address,
                        credit_card: credit_card)
    end

    it 'deletes an order' do
      delete "/api/magic/#{order.uuid}"

      expect(response).to have_http_status(:no_content)

      ord = Order.find_by(uuid: order.uuid)
      expect(ord).to be_nil
      expect(user.reload).to be_present
      expect(address.reload).to be_present
      expect(credit_card.reload).to be_present
    end

    it 'returns 404 if the order does not exist' do
      delete "/api/magic/123"

      expect(response).to have_http_status(:not_found)
    end
  end
end
