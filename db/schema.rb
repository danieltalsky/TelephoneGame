# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2014_09_01_013843) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.text "name"
    t.text "contact"
    t.text "bio"
    t.text "url"
    t.text "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "curated_tour_stops", force: :cascade do |t|
    t.text "caption_text"
    t.integer "sequential_id"
    t.integer "work_id"
    t.integer "curated_tour_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["curated_tour_id"], name: "index_curated_tour_stops_on_curated_tour_id"
    t.index ["work_id"], name: "index_curated_tour_stops_on_work_id"
  end

  create_table "curated_tours", force: :cascade do |t|
    t.string "tour_author"
    t.string "tour_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  create_table "work_representations", force: :cascade do |t|
    t.text "url"
    t.text "fileext"
    t.text "text_body_markdown"
    t.integer "work_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "works", force: :cascade do |t|
    t.text "title"
    t.integer "parent_id"
    t.integer "artist_id"
    t.text "orig_id"
    t.text "orig_parent_id"
    t.text "full_orig_id"
    t.text "medium"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
