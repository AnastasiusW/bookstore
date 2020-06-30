class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :deliveries, :method, :method_name
  end
end
