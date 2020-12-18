class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name

  def attributes
    {
      name: name,
      description: description,
      unit_price: unit_price,
      merchant_id: merchant_id
    }
  end
end
