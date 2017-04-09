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

ActiveRecord::Schema.define(version: 20170407223956) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ambassadorships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "area_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ambassadorships", ["area_id"], name: "index_ambassadorships_on_area_id", using: :btree
  add_index "ambassadorships", ["user_id"], name: "index_ambassadorships_on_user_id", using: :btree

  create_table "areas", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
  end

  create_table "article_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", force: :cascade do |t|
    t.integer  "area_id"
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "article_category_id"
    t.text     "body"
  end

  add_index "articles", ["area_id"], name: "index_articles_on_area_id", using: :btree
  add_index "articles", ["user_id"], name: "index_articles_on_user_id", using: :btree

  create_table "attachinary_files", force: :cascade do |t|
    t.integer  "attachinariable_id"
    t.string   "attachinariable_type"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachinary_files", ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree

  create_table "authorizations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.integer  "authorizable_id"
    t.string   "authorizable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "authorizations", ["authorizable_type", "authorizable_id"], name: "index_authorizations_on_authorizable_type_and_authorizable_id", using: :btree
  add_index "authorizations", ["role_id"], name: "index_authorizations_on_role_id", using: :btree
  add_index "authorizations", ["user_id"], name: "index_authorizations_on_user_id", using: :btree

  create_table "captioned_images", force: :cascade do |t|
    t.string   "caption"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "captioned_images", ["owner_type", "owner_id"], name: "index_captioned_images_on_owner_type_and_owner_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "mls_servers", force: :cascade do |t|
    t.string   "name"
    t.string   "server_hash"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "mls_servers", ["name"], name: "index_mls_servers_on_name", using: :btree

  create_table "open_house_searches", force: :cascade do |t|
    t.string   "neighborhood"
    t.integer  "sort_by"
    t.integer  "min_price"
    t.integer  "max_price"
    t.integer  "min_beds"
    t.integer  "max_beds"
    t.date     "from_date"
    t.date     "to_date"
    t.integer  "mls_server_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "open_house_searches", ["mls_server_id"], name: "index_open_house_searches_on_mls_server_id", using: :btree

  create_table "phone_calls", force: :cascade do |t|
    t.integer  "from_phone_id"
    t.integer  "profile_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "sid"
  end

  add_index "phone_calls", ["from_phone_id"], name: "index_phone_calls_on_from_phone_id", using: :btree
  add_index "phone_calls", ["profile_id"], name: "index_phone_calls_on_profile_id", using: :btree

  create_table "phones", force: :cascade do |t|
    t.string   "number"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "phones", ["owner_type", "owner_id"], name: "index_phones_on_owner_type_and_owner_id", using: :btree

  create_table "photo_albums", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "photo_albums", ["owner_type", "owner_id"], name: "index_photo_albums_on_owner_type_and_owner_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "profiled_id"
    t.string   "profiled_type"
    t.string   "name"
    t.text     "bio"
    t.string   "contact_email"
    t.string   "linked_in"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "instagram"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "username"
  end

  add_index "profiles", ["profiled_type", "profiled_id"], name: "index_profiles_on_profiled_type_and_profiled_id", using: :btree

  create_table "property_searches", force: :cascade do |t|
    t.integer  "min_price"
    t.integer  "max_price"
    t.integer  "min_beds"
    t.integer  "max_beds"
    t.integer  "min_baths"
    t.integer  "sort_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "rating",        default: 0.0, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "ratings", ["rateable_type", "rateable_id"], name: "index_ratings_on_rateable_type_and_rateable_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "services", force: :cascade do |t|
    t.integer  "vendor_id"
    t.string   "name"
    t.text     "description"
    t.integer  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "services", ["vendor_id"], name: "index_services_on_vendor_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vendors", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "ambassadorships", "areas"
  add_foreign_key "ambassadorships", "users"
  add_foreign_key "articles", "areas"
  add_foreign_key "articles", "users"
  add_foreign_key "authorizations", "roles"
  add_foreign_key "authorizations", "users"
  add_foreign_key "open_house_searches", "mls_servers"
  add_foreign_key "phone_calls", "profiles"
  add_foreign_key "ratings", "users"
  add_foreign_key "services", "vendors"
end
