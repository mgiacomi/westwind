class CreateFamilies < ActiveRecord::Migration[5.2]
  def change
    create_table "families", force: :cascade do |t|

      t.string  "name",                limit: 56
      t.string  "code",                limit: 56
      t.integer "lottery",             limit: 4, default: 0
      t.string  "phone",               limit: 20
      t.string  "email",               limit: 56
      t.integer "adults",              limit: 4, default: 0
      t.integer "kids",                limit: 4, default: 0
      t.integer "week",                limit: 1, default: 0
      t.integer "week1",               limit: 1, default: 0
      t.boolean "week1_withdrawn",     default: false
      t.integer "week2",               limit: 1, default: 0
      t.boolean "week2_withdrawn",     default: false
      t.integer "week3",               limit: 1, default: 0
      t.boolean "week3_withdrawn",     default: false
      t.boolean "onk_member",          default: false
      t.text "friends"

      t.timestamps
    end
  end
end
