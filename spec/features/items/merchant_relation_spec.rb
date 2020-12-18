require 'rails_helper'

describe Api::V1::Items::MerchantsController, type: :controller do
  describe 'index' do
    it do
      merchant1 = Merchant.create(name: 'harold')
      item1 = Item.create(name: 'adkfjadlkj', unit_price: 12.56, merchant_id: merchant1.id, description: 'its a thing')

      response = get :index, params: { id: item1.id }

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data][:attributes][:name]).to eq('harold')
    end
  end
end
