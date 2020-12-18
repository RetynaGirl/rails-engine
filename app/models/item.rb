class Item < ApplicationRecord
  belongs_to :merchant

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
