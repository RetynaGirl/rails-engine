require 'rails_helper'

describe Api::V1::Merchants::SearchController, type: :controller do
  describe 'show' do
    it 'results' do
      merchant1 = Merchant.create(name: 'harold')
      merchant2 = Merchant.create(name: 'wendy')


      response = get :show, params: { name: 'har' }

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data][:attributes][:name]).to eq('harold')

      response = get :show, params: { name: 'nd' }

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data][:attributes][:name]).to eq('wendy')
    end

    it 'no results' do
      merchant1 = Merchant.create(name: 'harold')
      merchant2 = Merchant.create(name: 'wendy')

      response = get :show, params: { name: 'stoopid' }

      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'index' do
    it 'results' do
      merchant1 = Merchant.create(name: 'harold')
      merchant2 = Merchant.create(name: 'wendy')

      response = get :index, params: { name: 'd' }
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data].length).to eq(2)

      expect(response).to have_http_status(:success)
    end
  end

  it 'no results' do
      merchant1 = Merchant.create(name: 'harold')
      merchant2 = Merchant.create(name: 'wendy')

      response = get :index, params: { name: 'stoopid' }

      expect(response).to have_http_status(:no_content)
    end
end
