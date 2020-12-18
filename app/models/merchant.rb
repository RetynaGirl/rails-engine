class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  def attributes
    {
      name: name
    }
  end
end
