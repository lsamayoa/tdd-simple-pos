# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141009025027) do

  create_table "clients", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["user_id"], name: "index_clients_on_user_id"

  create_table "employees", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.decimal  "salary"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employees", ["user_id"], name: "index_employees_on_user_id"

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "barcode_path"
    t.integer  "stock"
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id"

  create_table "sale_details", force: true do |t|
    t.integer  "sale_id"
    t.integer  "quantity"
    t.integer  "product_id"
    t.decimal  "subtotal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sale_details", ["product_id"], name: "index_sale_details_on_product_id"
  add_index "sale_details", ["sale_id"], name: "index_sale_details_on_sale_id"

  create_table "sales", force: true do |t|
    t.decimal  "total"
    t.integer  "client_id"
    t.integer  "seller_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sales", ["client_id"], name: "index_sales_on_client_id"
  add_index "sales", ["seller_id"], name: "index_sales_on_seller_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
