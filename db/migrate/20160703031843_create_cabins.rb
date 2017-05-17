class CreateCabins < ActiveRecord::Migration
  def change
    create_table "cabins", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"

      t.string   "name",   limit: 255

      t.timestamps
    end

    Cabin.create :name => "McIver Bunks (4x4)"
    Cabin.create :name => "McIver Open Area"
    Cabin.create :name => "Trillium (2)"
    Cabin.create :name => "Roost (5)"
    Cabin.create :name => "Wy'East (4)"
    Cabin.create :name => "Neskowin (2)"
    Cabin.create :name => "Robin Hood (9)"
    Cabin.create :name => "Maid Marion (9)"
    Cabin.create :name => "Nottingham (9)"
    Cabin.create :name => "Alan-A-Dale (9)"
    Cabin.create :name => "Aunt Vi's (14)"
    Cabin.create :name => "Hidel (9)"
    Cabin.create :name => "Tam'O Shanter (9)"
    Cabin.create :name => "Bagpiper (9)"
    Cabin.create :name => "Kilties (9)"
    Cabin.create :name => "Thistledown (9)"
    Cabin.create :name => "Klickitat (9)"
    Cabin.create :name => "Tyee (9)"
    Cabin.create :name => "Uncle Bliss (9)"
  end
end
