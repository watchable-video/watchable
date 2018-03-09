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

ActiveRecord::Schema.define(version: 2018_03_09_015741) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "cloudkit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cloudkit_id"], name: "index_accounts_on_cloudkit_id", unique: true
  end

  create_table "settings", force: :cascade do |t|
    t.bigint "account_id"
    t.integer "name", null: false
    t.jsonb "data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_settings_on_account_id"
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
    t.index ["cloudkit_id", "youtube_id"], name: "index_videos_on_cloudkit_id_and_youtube_id", unique: true
  end

  add_foreign_key "settings", "accounts"
end
