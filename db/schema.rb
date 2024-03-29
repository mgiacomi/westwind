# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2016_07_09_001021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cabins", force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "families", force: :cascade do |t|
    t.string "name", limit: 56
    t.string "code", limit: 56
    t.integer "lottery", default: 0
    t.string "phone", limit: 20
    t.string "email", limit: 56
    t.integer "adults", default: 0
    t.integer "kids", default: 0
    t.integer "week", limit: 2, default: 0
    t.integer "week1", limit: 2, default: 0
    t.boolean "week1_withdrawn", default: false
    t.integer "week2", limit: 2, default: 0
    t.boolean "week2_withdrawn", default: false
    t.integer "week3", limit: 2, default: 0
    t.boolean "week3_withdrawn", default: false
    t.boolean "onk_member", default: false
    t.boolean "host", default: false
    t.text "friends"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cabin_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "family_id"
    t.string "pmttype", limit: 255
    t.datetime "pmtdate"
    t.decimal "amount", precision: 6, scale: 2, default: "0.0"
    t.decimal "fee", precision: 6, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.integer "family_id"
    t.string "first", limit: 56
    t.string "last", limit: 56
    t.string "grade", limit: 56
    t.boolean "vegetarian", default: false
    t.boolean "vegan", default: false
    t.boolean "pescetarian", default: false
    t.boolean "gluten_free", default: false
    t.boolean "lactose_free", default: false
    t.boolean "no_dietary_issues", default: false
    t.boolean "no_allergies", default: false
    t.text "allergies"
    t.boolean "volunteer_intern_ride", default: false
    t.boolean "volunteer_meal_captain", default: false
    t.boolean "volunteer_campfire_leader", default: false
    t.boolean "volunteer_cascade_head", default: false
    t.boolean "volunteer_mud_mucking", default: false
    t.boolean "volunteer_crafts", default: false
    t.boolean "volunteer_sand_castles", default: false
    t.boolean "waiver_signed", default: false
    t.string "waiver_signed_relationship", limit: 56
    t.string "waiver_signed_name", limit: 56
    t.datetime "waiver_signed_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "waivers", force: :cascade do |t|
    t.integer "person_id"
    t.string "understand", limit: 255
    t.string "signature", limit: 255
    t.string "relationship", limit: 255
    t.string "first", limit: 255
    t.string "last", limit: 255
    t.string "email", limit: 255
    t.string "phone", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
