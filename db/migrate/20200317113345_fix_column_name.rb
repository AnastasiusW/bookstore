class FixColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :authors, :firstname, :first_name
    rename_column :authors, :lastname, :last_name
  end
end
