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

ActiveRecord::Schema.define(version: 2022_07_31_014729) do

  create_table "cart_items", charset: "utf8mb4", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "cart_id", null: false
    t.bigint "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
  end

  create_table "carts", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", charset: "utf8mb4", force: :cascade do |t|
    t.string "category_name", limit: 32
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_details", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "order_id"
    t.bigint "shipment_status_id"
    t.string "order_detail_number", limit: 64
    t.integer "order_quantity"
    t.timestamp "shipment_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["product_id"], name: "index_order_details_on_product_id"
    t.index ["shipment_status_id"], name: "index_order_details_on_shipment_status_id"
  end

  create_table "orders", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.timestamp "order_date"
    t.string "order_number", limit: 16
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "product_statuses", charset: "utf8mb4", force: :cascade do |t|
    t.string "product_status_name", limit: 32
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", charset: "utf8mb4", force: :cascade do |t|
    t.string "product_name", limit: 64
    t.bigint "category_id"
    t.integer "price"
    t.string "description", limit: 256
    t.bigint "sale_status_id"
    t.bigint "product_status_id"
    t.timestamp "regist_date"
    t.bigint "user_id"
    t.boolean "delete_flg"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["product_status_id"], name: "index_products_on_product_status_id"
    t.index ["sale_status_id"], name: "index_products_on_sale_status_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "purchases", charset: "utf8mb4", force: :cascade do |t|
    t.integer "purchase_price"
    t.integer "purchase_quantity"
    t.string "purchase_company", limit: 128
    t.timestamp "order_date"
    t.timestamp "purchase_date"
    t.bigint "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_purchases_on_product_id"
  end

  create_table "sale_statuses", charset: "utf8mb4", force: :cascade do |t|
    t.string "sale_status_name", limit: 32
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "shipment_statuses", charset: "utf8mb4", force: :cascade do |t|
    t.string "shipment_status_name", limit: 32
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_classifications", charset: "utf8mb4", force: :cascade do |t|
    t.string "user_classification_name", limit: 32
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "password_digest", limit: 64
    t.string "last_name", limit: 16
    t.string "first_name", limit: 16
    t.string "zipcode", limit: 16
    t.string "prefecture", limit: 16
    t.string "municipality", limit: 16
    t.string "address", limit: 32
    t.string "apartments", limit: 32
    t.string "email", limit: 128
    t.string "phone_number", limit: 16
    t.bigint "user_classification_id"
    t.string "company_name", limit: 128
    t.boolean "delete_flg"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_classification_id"], name: "index_users_on_user_classification_id"
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "products"
  add_foreign_key "carts", "users"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "products"
  add_foreign_key "order_details", "shipment_statuses"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "product_statuses"
  add_foreign_key "products", "sale_statuses"
  add_foreign_key "products", "users"
  add_foreign_key "purchases", "products"
  add_foreign_key "users", "user_classifications"
end
