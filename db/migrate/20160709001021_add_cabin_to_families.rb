class AddCabinToFamilies < ActiveRecord::Migration[5.2]
  def change
    add_column :families, :cabin_id, :int
  end
end
