class AddCabinToFamilies < ActiveRecord::Migration
  def change
    add_column :families, :cabin_id, :int
  end
end
