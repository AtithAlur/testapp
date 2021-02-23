# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.uuid :uuid, index: true
      t.string :first_name, limit: 50
      t.string :last_name, limit: 50
      t.string :email, limit: 50, unique: true
      t.column :phone_number, 'char(10)'

      t.timestamps
    end
  end
end
