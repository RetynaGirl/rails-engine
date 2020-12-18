require 'rails_helper'
# Rspec has decided to just not have any shoulda-matchers work, so thats fun

describe Item, type: :model do
  # describe 'validations' do
  #   it do
  #     should validate_presence_of :name
  #   end
  # end

  # describe 'relationships' do
  #   it do
  #     should belong_to :merchant
  #     should have_many :invoices
  #     should have_many(:invoice_items).through(:invoices)
  #   end
  # end

  describe 'instance methods' do
    it 'attributes' do
      item = Item.new(
        id: 4,
        name: 'trash can',
        description: 'duh',
        unit_price: 6.99,
        merchant_id: 5
      )

      expected = {
        name: 'trash can',
        description: 'duh',
        unit_price: 6.99,
        merchant_id: 5
      }

      expect(item.attributes).to eq(expected)
    end
  end
end
