# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_17_051952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.uuid "uuid"
    t.integer "user_id"
    t.string "address_line1", limit: 50
    t.string "address_line2", limit: 50
    t.string "city", limit: 20
    t.string "state", limit: 2
    t.string "zip", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_line1"], name: "index_addresses_on_address_line1"
    t.index ["uuid"], name: "index_addresses_on_uuid"
  end

  create_table "credit_cards", force: :cascade do |t|
    t.uuid "uuid"
    t.integer "user_id"
    t.string "card_number", limit: 20
    t.string "expiry", limit: 7
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["card_number"], name: "index_credit_cards_on_card_number"
    t.index ["uuid"], name: "index_credit_cards_on_uuid"
  end

  create_table "order_products", force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.integer "price_id"
    t.integer "quantity"
    t.decimal "sub_total", precision: 10, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id", "product_id"], name: "index_order_products_on_order_id_and_product_id", unique: true
  end

# Could not dump table "orders" because of following StandardError
#   Unknown type 'order_status' for column 'status'

  create_table "prices", force: :cascade do |t|
    t.integer "product_id"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.uuid "uuid"
    t.string "name", limit: 50
    t.integer "order_limit"
    t.text "description"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_products_on_name"
    t.index ["uuid"], name: "index_products_on_uuid"
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "product_id"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.uuid "uuid"
    t.string "first_name", limit: 50
    t.string "last_name", limit: 50
    t.string "email", limit: 50
    t.string "phone_number", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uuid"], name: "index_users_on_uuid"
  end

end
