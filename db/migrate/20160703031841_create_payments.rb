class CreatePayments < ActiveRecord::Migration
  def change
    create_table "payments", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"

      t.integer  "family_id", limit: 4
      t.string   "pmttype",   limit: 255
      t.datetime "pmtdate"
      t.decimal  "amount",    precision: 6, scale: 2, default: 0
      t.decimal  "fee",       precision: 6, scale: 2, default: 0

      t.timestamps
    end

  end
end
