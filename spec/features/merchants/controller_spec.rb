require 'rails_helper'
require 'rspec'
require 'rspec-rails'

RSpec.describe Api::V1::MerchantsController, type: :controller do
  describe 'index' do
    it 'Some merchants' do
      merchant1 = Merchant.create(name: 'adkfjadlkj')
      merchant2 = Merchant.create(name: 'steve')

      response = get :index
      data = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry

      expect(data[:data][0][:attributes][:name]).to eq('adkfjadlkj')
      expect(data[:data][1][:attributes][:name]).to eq('steve')
      expect(response).to have_http_status(:success)
    end

    it 'no merchants' do
      response = get :index
      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'show' do
    it 'good request' do
      merchant1 = Merchant.create(name: 'adkfjadlkj')

      response = get(:show, params: { id: merchant1.id })
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data][:attributes][:name]).to eq('adkfjadlkj')

      expect(response).to have_http_status(:success)
    end

    it 'bad request' do
      response = get(:show, params: { id: 0 })

      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'create' do
    it 'good request' do
      response = post :create, params: { name: 'Edwin' }

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data][:attributes][:name]).to eq('Edwin')

      expect(response).to have_http_status(:success)
    end
  end

  describe 'update' do
    it 'good request' do
      merchant1 = Merchant.create(name: 'steve')

      response = patch :update, params: { id: merchant1.id, name: 'Harold' }

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data][:attributes][:name]).to eq('Harold')

      expect(response).to have_http_status(:success)
    end
  end

  describe 'destroy' do
    it 'good request' do
      merchant1 = Merchant.create(name: 'steve')

      response = delete :destroy, params: { id: merchant1.id }

      expect(response).to have_http_status(:no_content)

      response = get :index

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:data][1]).to be_nil
    end
  end
end
