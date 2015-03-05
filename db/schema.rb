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

ActiveRecord::Schema.define(version: 20150305180316) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
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

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "affiliates", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "get_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "approvals", force: true do |t|
    t.integer  "affiliate_id"
    t.integer  "award_id"
    t.string   "approval_method"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "awards", force: true do |t|
    t.integer  "patient_id"
    t.integer  "award_type"
    t.float    "total_requested"
    t.float    "total_granted"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vendor"
    t.datetime "date_of_service"
  end

  create_table "blog_posts", force: true do |t|
    t.string   "title"
    t.string   "author"
    t.text     "content"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", force: true do |t|
    t.integer  "award_id"
    t.string   "name"
    t.string   "device_type"
    t.float    "unit_cost"
    t.integer  "quantity"
    t.float    "total_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paid"
  end

  create_table "medications", force: true do |t|
    t.integer  "award_id"
    t.string   "id_number"
    t.string   "name"
    t.float    "unit_cost"
    t.integer  "quantity"
    t.float    "total_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paid"
  end

  create_table "notes", force: true do |t|
    t.text     "content"
    t.integer  "referral_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.datetime "birthday"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "home_phone"
    t.string   "work_phone"
    t.string   "diagnosis"
    t.integer  "diagnosis_confirmed"
    t.float    "lifetime_total"
    t.float    "year_total"
    t.float    "quarter_total"
    t.integer  "low_income"
    t.string   "income_sources"
    t.string   "advocate_firstname"
    t.string   "advocate_lastname"
    t.string   "advocate_phone"
    t.string   "advocate_email"
    t.datetime "deleted"
  end

  create_table "ref_insurances", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ref_meds", force: true do |t|
    t.string   "drug"
    t.string   "icd9"
    t.string   "diagnosis"
    t.float    "doscage"
    t.string   "sig"
    t.string   "dispense"
    t.string   "refills"
    t.integer  "referral_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ref_pysicians", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "referrals", force: true do |t|
    t.string   "advocate_email"
    t.integer  "referring_physician_id"
    t.string   "prefix"
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "home_phone"
    t.string   "work_phone"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "id_num"
    t.datetime "date_of_birth"
    t.string   "gender"
    t.string   "married"
    t.string   "employed"
    t.integer  "citizen"
    t.integer  "household_size"
    t.float    "income"
    t.string   "income_sources"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "app_sent"
    t.integer  "app_sent_by"
  end

  create_table "sliders", force: true do |t|
    t.string   "image"
    t.string   "image_alt"
    t.string   "text1"
    t.string   "text2"
    t.string   "text3"
    t.string   "text4"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "action"
    t.string   "controller"
  end

  create_table "supplements", force: true do |t|
    t.integer  "award_id"
    t.string   "name"
    t.float    "unit_cost"
    t.integer  "quantity"
    t.float    "total_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paid"
  end

  create_table "transports", force: true do |t|
    t.integer  "award_id"
    t.integer  "number_of_miles"
    t.decimal  "cost_per_mile",   precision: 5, scale: 3
    t.integer  "number_trips"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paid"
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
    t.string   "name"
    t.boolean  "admin"
    t.integer  "role"
    t.integer  "affiliate_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
