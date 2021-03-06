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

ActiveRecord::Schema.define(version: 2018_07_21_040318) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "cloudkit_id", null: false
    t.string "google_auth_data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "settings", default: {}
    t.index ["cloudkit_id"], name: "index_accounts_on_cloudkit_id", unique: true
  end

  create_table "activation_tokens", force: :cascade do |t|
    t.string "cloudkit_id", null: false
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cloudkit_id", "token"], name: "index_activation_tokens_on_cloudkit_id_and_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "youtube_id", null: false
    t.string "cloudkit_id", null: false
    t.datetime "video_published_at", null: false
    t.integer "progress", default: 0, null: false
    t.boolean "watched", default: false, null: false
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "file_path", default: [], array: true
    t.index ["cloudkit_id", "youtube_id"], name: "index_videos_on_cloudkit_id_and_youtube_id", unique: true
  end

end
