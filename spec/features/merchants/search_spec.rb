require 'rails_helper'

describe Api::V1::Merchants::SearchController, type: :controller do
  describe 'show' do
    it do
      merchant1 = Merchant.create(name: 'harold')
      merchant2 = Merchant.create(name: 'wendy')


      response = get :show, params: { name: 'har' }

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data][:attributes][:name]).to eq('harold')

      response = get :show, params: { name: 'nd' }

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data][:attributes][:name]).to eq('wendy')
    end
  end
end
