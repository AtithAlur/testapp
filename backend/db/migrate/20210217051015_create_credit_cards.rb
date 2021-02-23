# frozen_string_literal: true

class CreateCreditCards < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_cards do |t|
      t.uuid :uuid, index: true
      t.integer :user_id
      t.string :card_number, limit: 20, index: true
      t.column :expiry, 'char(7)'

      t.timestamps
    end
  end
end
