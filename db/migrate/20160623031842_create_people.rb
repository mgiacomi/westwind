class CreatePeople < ActiveRecord::Migration
  def change
    create_table "people", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"

      t.integer "family_id",                 limit: 4
      t.string  "first",                     limit: 56
      t.string  "last",                      limit: 56
      t.string  "grade",                     limit: 56

      t.boolean  "vegetarian",                default: false
      t.boolean  "vegan",                     default: false
      t.boolean  "pescetarian",               default: false
      t.boolean  "gluten_free",               default: false
      t.boolean  "lactose_free",              default: false
      t.boolean  "no_dietary_issues",         default: false
      t.boolean  "no_allergies",              default: false
      t.text     "allergies"

      t.boolean  "volunteer_meal_captain",    default: false
      t.boolean  "volunteer_campfire_leader", default: false
      t.boolean  "volunteer_cascade_head",    default: false
      t.boolean  "volunteer_mud_mucking",     default: false
      t.boolean  "volunteer_crafts",          default: false
      t.boolean  "volunteer_sand_castles",    default: false

      t.boolean  "waiver_signed",              default: false
      t.string   "waiver_signed_relationship", limit: 56
      t.string   "waiver_signed_name",         limit: 56
      t.datetime "waiver_signed_date"

    end
  end
end
