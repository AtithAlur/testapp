# frozen_string_literal: true

class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.integer :product_id
      t.integer :quantity

      t.timestamps
    end
  end
end
