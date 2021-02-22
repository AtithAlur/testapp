# frozen_string_literal: true

class CreatePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :prices do |t|
      t.integer :product_id
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
