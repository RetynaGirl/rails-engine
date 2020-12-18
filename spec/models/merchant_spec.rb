require 'rails_helper'

describe Merchant, type: :model do
  # describe 'validations' do
  #   it do
  #     should validate_presence_of :name
  #   end
  # end

  # describe 'relationships' do
  #   it do

  #     should have_many :invoices
  #     should have_many(:invoice_items).through(:invoices)
  #   end
  # end

  describe 'instance methods' do
    it 'attributes' do
      merchant = Merchant.new(
        id: 8,
        name: 'Billy bob joe'
      )

      expected = {
        name: 'Billy bob joe'
      }

      expect(merchant.attributes).to eq(expected)
    end
  end
end
