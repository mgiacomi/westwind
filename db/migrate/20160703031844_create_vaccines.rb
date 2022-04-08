class CreateVaccines < ActiveRecord::Migration[5.2]
  def change
    create_table "vaccines", force: :cascade do |t|

      t.integer  "family_id",    limit: 4
      t.string   "understand",   limit: 255
      t.string   "signature",    limit: 255
      t.string   "first",        limit: 255
      t.string   "last",         limit: 255
      t.string   "party",        limit: 1024

      t.timestamps
    end

  end
end
