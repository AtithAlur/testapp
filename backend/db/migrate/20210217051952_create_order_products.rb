# frozen_string_literal: true

class CreateOrderProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :order_products do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :price_id
      t.integer :quantity
      t.decimal :sub_total, precision: 10, scale: 2

      t.timestamps
    end

    add_index :order_products, [:order_id, :product_id], unique: true
  end
end
