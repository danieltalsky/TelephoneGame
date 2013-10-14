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

ActiveRecord::Schema.define(version: 20131014002929) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: true do |t|
    t.text     "name"
    t.text     "contact"
    t.text     "bio"
    t.text     "url"
    t.text     "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "work_representations", force: true do |t|
    t.text     "url"
    t.text     "fileext"
    t.text     "text_body_markdown"
    t.integer  "work_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "work_representations", ["work_id"], name: "index_work_representations_on_work_id", using: :btree

  create_table "works", force: true do |t|
    t.text     "title"
    t.integer  "parent_id"
    t.integer  "artist_id"
    t.text     "orig_id"
    t.text     "orig_parent_id"
    t.text     "full_orig_id"
    t.text     "medium"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
