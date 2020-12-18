require 'rails_helper'

describe Api::V1::ItemsController, type: :controller do
  describe 'index' do
    it 'Some items' do
      merchant1 = Merchant.create(name: 'harold')
      item1 = Item.create(name: 'adkfjadlkj', unit_price: 12.56, merchant_id: merchant1.id, description: 'its a thing')
      item2 = Item.create(name: 'cart', unit_price: 4.55, merchant_id: merchant1.id, description: 'Its a little cart')

      response = get :index
      data = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry

      expect(data[:data][0][:attributes][:name]).to eq('adkfjadlkj')
      expect(data[:data][0][:attributes][:unit_price]).to eq(12.56)
      expect(data[:data][0][:attributes][:merchant_id]).to eq(merchant1.id)
      expect(data[:data][0][:attributes][:description]).to eq('its a thing')
      expect(data[:data][1][:attributes][:name]).to eq('cart')
      expect(response).to have_http_status(:success)
    end

    it 'no items' do
      response = get :index
      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'show' do
    it 'good request' do
      merchant1 = Merchant.create(name: 'harold')
      item1 = Item.create(name: 'adkfjadlkj', unit_price: 12.56, merchant_id: merchant1.id, description: 'its a thing')

      response = get(:show, params: { id: item1.id })
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data][:attributes][:name]).to eq('adkfjadlkj')
      expect(data[:data][:attributes][:unit_price]).to eq(12.56)
      expect(data[:data][:attributes][:merchant_id]).to eq(merchant1.id)
      expect(data[:data][:attributes][:description]).to eq('its a thing')
      expect(response).to have_http_status(:success)
    end

    it 'bad request' do
      response = get(:show, params: { id: 0 })

      expect(response).to have_http_status(:no_content)
    end
  end
end
