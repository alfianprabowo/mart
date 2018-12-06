# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.


ActiveRecord::Schema.define(version: 2018_12_03_122858) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "item_cats", force: :cascade do |t|
    t.string "name", default: "DEFAULT", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "code", default: "DEFAULT_CODE", null: false
    t.string "name", default: "DEFAULT_NAME", null: false
    t.integer "stock", default: 0, null: false
    t.integer "buy", default: 1, null: false
    t.integer "sell", default: 1, null: false
    t.bigint "item_cat_id", null: false
    t.index ["item_cat_id"], name: "index_items_on_item_cat_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name", null: false
    t.string "id_card"
    t.string "card_number", null: false
    t.bigint "phone", null: false
    t.integer "sex"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "retur_items", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "retur_id", null: false
    t.integer "quantity", null: false
    t.string "description", null: false
    t.integer "feedback", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "accept_item", default: 0
    t.integer "nominal", default: 0, null: false
    t.index ["item_id"], name: "index_retur_items_on_item_id"
    t.index ["retur_id"], name: "index_retur_items_on_retur_id"
  end

  create_table "returs", force: :cascade do |t|
    t.string "invoice", null: false
    t.integer "total_items", null: false
    t.bigint "store_id", null: false
    t.bigint "supplier_id", null: false
    t.datetime "date_created"
    t.datetime "date_picked"
    t.datetime "date_approve"
    t.datetime "status"
    t.index ["store_id"], name: "index_returs_on_store_id"
    t.index ["supplier_id"], name: "index_returs_on_supplier_id"
  end

  create_table "store_items", force: :cascade do |t|
    t.bigint "store_id", null: false
    t.bigint "item_id", null: false
    t.integer "stock", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_store_items_on_item_id"
    t.index ["store_id"], name: "index_store_items_on_store_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name", default: "DEFAULT STORE NAME", null: false
    t.string "address", default: "DEFAULT STORE ADDRESS", null: false
    t.bigint "phone", default: 1234567, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "store_type", default: 0
  end

  create_table "supplier_items", force: :cascade do |t|
    t.bigint "supplier_id", null: false
    t.bigint "item_id", null: false
    t.integer "price", null: false
    t.integer "min_qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_supplier_items_on_item_id"
    t.index ["supplier_id"], name: "index_supplier_items_on_supplier_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "pic", default: "DEFAULT NAME SUPPLIER", null: false
    t.string "address", default: "DEFAULT ADDRESS SUPPLIER", null: false
    t.bigint "phone", default: 123456789, null: false
    t.integer "supplier_type", default: 0
  end

  create_table "transfer_items", force: :cascade do |t|
    t.bigint "transfer_id", null: false
    t.bigint "item_id", null: false
    t.integer "request_quantity", default: 1, null: false
    t.integer "sent_quantity", default: 0
    t.integer "receive_quantity", default: 0
    t.string "description", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_transfer_items_on_item_id"
    t.index ["transfer_id"], name: "index_transfer_items_on_transfer_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.string "invoice", null: false
    t.datetime "date_created", null: false
    t.datetime "date_approve"
    t.datetime "date_picked"
    t.datetime "date_confirm"
    t.datetime "status"
    t.integer "total_items"
    t.bigint "from_store_id", null: false
    t.bigint "to_store_id", null: false
    t.index ["from_store_id"], name: "index_transfers_on_from_store_id"
    t.index ["to_store_id"], name: "index_transfers_on_to_store_id"
  end

  create_table "table_trx_types", force: :cascade do |t|
    t.string "name", default: "DEFAULT", null: false
  end

  create_table "transaction_items", force: :cascade do |t|
  end

  create_table "transaction_types", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "transactions", force: :cascade do |t|
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.integer "level", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", limit: 128
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128
    t.bigint "phone", default: 8123456789, null: false
    t.string "address", default: "DEFAULT ADDRESS", null: false
    t.bigint "id_card", default: 123456789123456, null: false
    t.integer "sex", default: 0, null: false
    t.bigint "store_id"
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
    t.index ["store_id"], name: "index_users_on_store_id"
  end

  add_foreign_key "items", "item_cats"
  add_foreign_key "retur_items", "items"
  add_foreign_key "retur_items", "returs"
  add_foreign_key "returs", "stores"
  add_foreign_key "returs", "suppliers"
  add_foreign_key "store_items", "items"
  add_foreign_key "store_items", "stores"
  add_foreign_key "supplier_items", "items"
  add_foreign_key "supplier_items", "suppliers"
  add_foreign_key "transfer_items", "items"
  add_foreign_key "transfer_items", "transfers"
  add_foreign_key "transfers", "stores", column: "from_store_id"
  add_foreign_key "transfers", "stores", column: "to_store_id"
  add_foreign_key "users", "stores"
end
