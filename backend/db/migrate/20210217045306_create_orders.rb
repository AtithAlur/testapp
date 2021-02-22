# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE TYPE order_status AS ENUM ('pending', 'fulfilled', 'delivered', 'canceled');
    SQL

    create_table :orders do |t|
      t.uuid :uuid, index: true
      t.integer :user_id
      t.integer :credit_card_id
      t.integer :address_id
      t.column :status, :order_status
      t.decimal :total, precision: 10, scale: 2

      t.timestamps
    end
  end

  def down
    drop_table :orders

    execute <<-SQL
      DROP TYPE order_status;
    SQL
  end
end
