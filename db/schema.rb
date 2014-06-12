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

ActiveRecord::Schema.define(version: 20140612143450) do

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "games", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year"
    t.text     "description"
    t.string   "genre"
    t.string   "platform"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.string   "slug"
    t.string   "asin"
    t.date     "rlsdate"
    t.string   "developer"
    t.string   "publisher"
    t.integer  "score"
    t.string   "list_price"
    t.string   "lowest_price"
    t.string   "savings"
    t.string   "wishlist_url"
    t.binary   "similar_products"
    t.string   "page_url"
  end

  add_index "games", ["genre"], name: "index_games_on_genre"
  add_index "games", ["platform"], name: "index_games_on_platform"
  add_index "games", ["slug"], name: "index_games_on_slug"
  add_index "games", ["year"], name: "index_games_on_year"

  create_table "ownerships", force: true do |t|
    t.integer  "owner_id"
    t.integer  "owned_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ownerships", ["owned_id"], name: "index_ownerships_on_owned_id"
  add_index "ownerships", ["owner_id", "owned_id"], name: "index_ownerships_on_owner_id_and_owned_id", unique: true
  add_index "ownerships", ["owner_id"], name: "index_ownerships_on_owner_id"

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "wishlists", force: true do |t|
    t.integer  "wisher_id"
    t.integer  "wished_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wishlists", ["wished_id", "wisher_id"], name: "index_wishlists_on_wished_id_and_wisher_id", unique: true
  add_index "wishlists", ["wished_id"], name: "index_wishlists_on_wished_id"
  add_index "wishlists", ["wisher_id"], name: "index_wishlists_on_wisher_id"

end
