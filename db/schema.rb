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

ActiveRecord::Schema.define(version: 20170110220731) do

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
    t.text     "body"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "article_category_id"
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
  end

  add_index "profiles", ["profiled_type", "profiled_id"], name: "index_profiles_on_profiled_type_and_profiled_id", using: :btree

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
  add_foreign_key "ratings", "users"
end
