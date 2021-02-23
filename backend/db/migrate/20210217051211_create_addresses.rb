# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.uuid :uuid, index: true
      t.integer :user_id
      t.string :address_line1, limit: 50, index: true
      t.string :address_line2, limit: 50
      t.string :city, limit: 20
      t.column :state, 'char(2)'
      t.string :zip, limit: 10

      t.timestamps
    end
  end
end
