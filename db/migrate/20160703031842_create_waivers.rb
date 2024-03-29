class CreateWaivers < ActiveRecord::Migration[5.2]
  def change
    create_table "waivers", force: :cascade do |t|

      t.integer  "person_id",    limit: 4
      t.string   "understand",   limit: 255
      t.string   "signature",    limit: 255
      t.string   "relationship", limit: 255
      t.string   "first",        limit: 255
      t.string   "last",         limit: 255
      t.string   "email",        limit: 255
      t.string   "phone",        limit: 255

      t.timestamps
    end

  end
end
