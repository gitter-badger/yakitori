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

ActiveRecord::Schema.define(version: 20140910044711) do

  create_table "genres", force: true do |t|
    t.string   "name"
    t.string   "pay_label"
    t.string   "free_label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "extension"
    t.integer  "id_label"
  end

  create_table "prices", force: true do |t|
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "version"
    t.string   "thumbnail_name"
    t.string   "exported_name"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label"
    t.integer  "genre_id"
  end

  create_table "sale_categories", force: true do |t|
    t.string   "name"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sale_products", force: true do |t|
    t.integer  "sale_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "display_order"
    t.string   "thumbnail_url"
    t.string   "preview1_url"
    t.string   "preview2_url"
    t.string   "preview3_url"
    t.string   "preview4_url"
    t.string   "preview5_url"
    t.boolean  "visible"
    t.datetime "approval_at"
    t.boolean  "is_new"
    t.integer  "area"
    t.string   "optimum_plan"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price_id"
    t.integer  "sale_category_id"
  end

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "app_type"
    t.integer  "paid"
    t.datetime "release_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
