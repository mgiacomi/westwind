class CreateCabins < ActiveRecord::Migration[5.2]
  def change
    create_table "cabins", force: :cascade do |t|
      t.string   "name",   limit: 255
      t.timestamps
    end
  end
end
