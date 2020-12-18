require 'rails_helper'

describe Api::V1::Items::SearchController, type: :controller do
  describe 'show' do
    it do
      merchant1 = Merchant.create(name: 'harold')

      item1 = Item.create(name: 'adkfjadlkj', unit_price: 12.00, merchant_id: merchant1.id, description: 'its a thing')
      item2 = Item.create(name: 'cart', unit_price: 4.00, merchant_id: merchant1.id, description: 'Its a little cart')

      response = get :show, params: { name: 'car' }

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data][:attributes][:name]).to eq('cart')

      response = get :show, params: { description: 'thi' }

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data][:attributes][:name]).to eq('adkfjadlkj')
    end
  end

  describe 'index' do
    it do
      merchant1 = Merchant.create(name: 'harold')

      item1 = Item.create(name: 'adkfjadlkj', unit_price: 12.00, merchant_id: merchant1.id, description: 'its a thing')
      item2 = Item.create(name: 'cart', unit_price: 4.00, merchant_id: merchant1.id, description: 'Its a little cart')

      response = get :index, params: { description: 'its' }
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data].length).to eq(2)

      expect(response).to have_http_status(:success)
    end
  end
end
