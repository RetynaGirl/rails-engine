class CreateItem < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :unit_price
      t.bigint :merchant_id

      t.timestamps
    end
  end
end