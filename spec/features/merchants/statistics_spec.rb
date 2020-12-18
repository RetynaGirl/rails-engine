require 'rails_helper'

describe Api::V1::Merchants::StatisticsController, type: :controller do
  before :each do
    @merchant1 = Merchant.create(name: 'harold')
    @merchant2 = Merchant.create(name: 'wendy')
    @merchant3 = Merchant.create(name: 'bill')

    @item1 = Item.create(name: 'adkfjadlkj', unit_price: 12.00, merchant_id: @merchant1.id, description: 'its a thing')
    @item2 = Item.create(name: 'cart', unit_price: 4.00, merchant_id: @merchant1.id, description: 'Its a little cart')
    @item3 = Item.create(name: 'box', unit_price: 2.00, merchant_id: @merchant2.id, description: 'Its a little box')
    @item4 = Item.create(name: 'tray', unit_price: 5.00, merchant_id: @merchant2.id, description: 'Its a little tray')
    @item5 = Item.create(name: 'rope', unit_price: 10.00, merchant_id: @merchant3.id, description: 'Its a little rope')
    @item6 = Item.create(name: 'bowl', unit_price: 15.00, merchant_id: @merchant3.id, description: 'Its a little bowl')

    @customer = Customer.create(first_name: 'Jerry', last_name: 'Springer')

    @invoice1 = @customer.invoices.create(merchant: @merchant1, status: 'shipped')
    @invoice2 = @customer.invoices.create(merchant: @merchant2, status: 'shipped')
    @invoice3 = @customer.invoices.create(merchant: @merchant3, status: 'shipped')

    @invitem1 = @invoice1.invoice_items.create(item: @item1, quantity: 4, unit_price: @item1.unit_price)
    @invitem2 = @invoice1.invoice_items.create(item: @item2, quantity: 8, unit_price: @item2.unit_price)
    @invitem3 = @invoice2.invoice_items.create(item: @item4, quantity: 6, unit_price: @item4.unit_price)
    @invitem4 = @invoice2.invoice_items.create(item: @item3, quantity: 12, unit_price: @item3.unit_price)
    @invitem5 = @invoice3.invoice_items.create(item: @item5, quantity: 3, unit_price: @item5.unit_price)
    @invitem6 = @invoice3.invoice_items.create(item: @item6, quantity: 4, unit_price: @item6.unit_price)

    @transaction1 = @invoice1.transactions.create(credit_card_number: '4017503416578382', credit_card_expiration_date: '04/23', result: 'success')
    @transaction2 = @invoice2.transactions.create(credit_card_number: '4017503416578382', credit_card_expiration_date: '04/23', result: 'success')
    @transaction3 = @invoice3.transactions.create(credit_card_number: '4017503416578382', credit_card_expiration_date: '04/23', result: 'success')
  end

  describe 'most_revenue' do
    it do
      response = get :most_revenue
      data = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry
      expect(data[:data][0][:id]).to eq(@merchant3.id.to_s)
      expect(data[:data][1][:id]).to eq(@merchant1.id.to_s)
      expect(data[:data][2][:id]).to eq(@merchant2.id.to_s)
    end
  end

  describe 'most_items_sold' do
    it do
      response = get :most_items_sold
      data = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry
      expect(data[:data][0][:id]).to eq(@merchant2.id.to_s)
      expect(data[:data][1][:id]).to eq(@merchant1.id.to_s)
      expect(data[:data][2][:id]).to eq(@merchant3.id.to_s)
    end
  end

  describe 'revenue' do
    it 'merchant 1' do
      response = get :revenue, params: { id: @merchant1.id }
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data][:attributes][:revenue]).to eq(80.0)
    end

    it 'merchant 2' do
      response = get :revenue, params: { id: @merchant2.id }
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data][:attributes][:revenue]).to eq(54.0)
    end

    it 'merchant 3' do
      response = get :revenue, params: { id: @merchant3.id }
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data][:attributes][:revenue]).to eq(90.0)
    end
  end
end
