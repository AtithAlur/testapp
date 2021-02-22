require 'rails_helper'

RSpec.describe "Api::Products", type: :request do
  let!(:products) { FactoryBot.create_list(:product, 10) }

  describe '#index' do
    let(:expected_response) do
      {
        'products' => products.map do|product|
          {
            'uuid' => product.uuid,
            'name' => product.name,
            'description' => product.description,
            'price' => product.prices.last.price.to_d.to_s,
            'imageUrl' => product.image.url,
            'orderLimit' => product.order_limit
          }
        end
      }
    end

    it 'returns all products' do
      get '/api/products'

      response_body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(response_body).to eq(expected_response)
    end
  end
end
