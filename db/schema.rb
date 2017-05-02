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

ActiveRecord::Schema.define(version: 20170502054939) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "assignments", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "service_request_id"
    t.uuid     "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "attachments", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "file"
    t.uuid     "service_request_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "categories", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.uuid     "service_request_id"
    t.uuid     "user_id"
    t.text     "body"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "images", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "file"
    t.uuid     "service_request_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "royce_connector", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid     "roleable_id",   null: false
    t.string   "roleable_type", null: false
    t.uuid     "role_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "royce_connector", ["role_id"], name: "index_royce_connector_on_role_id", using: :btree
  add_index "royce_connector", ["roleable_id", "roleable_type"], name: "index_royce_connector_on_roleable_id_and_roleable_type", using: :btree

  create_table "royce_role", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "royce_role", ["name"], name: "index_royce_role_on_name", using: :btree

  create_table "service_requests", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "request_id"
    t.string   "title"
    t.uuid     "customer_id"
    t.uuid     "category_id"
    t.text     "description"
    t.date     "deadline"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "state"
  end

  create_table "users", id: :uuid, default: nil, force: :cascade do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
