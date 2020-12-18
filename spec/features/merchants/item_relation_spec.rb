require 'rails_helper'

describe Api::V1::Merchants::ItemsController, type: :controller do
  describe 'index' do
    it do
      merchant1 = Merchant.create(name: 'harold')
      item1 = Item.create(name: 'wheee', unit_price: 12.56, merchant_id: merchant1.id, description: 'its a thing')
      item2 = Item.create(name: 'cart', unit_price: 4.55, merchant_id: merchant1.id, description: 'Its a little cart')

      response = get :index, params: { id: merchant1.id }

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data][0][:attributes][:name]).to eq('wheee')
      expect(data[:data][1][:attributes][:name]).to eq('cart')
    end
  end
end
