# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.uuid :uuid, index: true
      t.string :name, limit: 50, index: true
      t.integer :order_limit
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
