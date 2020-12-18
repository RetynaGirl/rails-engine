require 'rails_helper'

describe Api::V1::StatisticsController, type: :controller do
  it 'revenue_date_range' do
    merchant1 = Merchant.create(name: 'harold')

    item1 = Item.create(name: 'adkfjadlkj', unit_price: 12.00, merchant_id: merchant1.id, description: 'its a thing')
    item2 = Item.create(name: 'cart', unit_price: 4.00, merchant_id: merchant1.id, description: 'Its a little cart')

    customer = Customer.create(first_name: 'Jerry', last_name: 'Springer')

    invoice1 = customer.invoices.create(merchant: merchant1, status: 'shipped')
    invoice2 = customer.invoices.create(merchant: merchant1, status: 'shipped')

    invitem1 = invoice1.invoice_items.create(item: item1, quantity: 4, unit_price: item1.unit_price)
    invitem1 = invoice2.invoice_items.create(item: item2, quantity: 8, unit_price: item2.unit_price)

    transaction1 = invoice1.transactions.create(credit_card_number: '4017503416578382', credit_card_expiration_date: '04/23', result: 'success')
    transaction2 = invoice2.transactions.create(credit_card_number: '4017503416578382', credit_card_expiration_date: '04/23', result: 'success')

    start_date = DateTime.now.prev_day.strftime('%Y-%m-%d')
    end_date = DateTime.now.next_day.strftime('%Y-%m-%d')

    response = get :revenue_date_range, params: { start: start_date, end: end_date }
    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:data][:attributes][:revenue]).to eq(80.0)
  end
end
