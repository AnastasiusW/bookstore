class AddColumnToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :step, :integer, default: 0
  end
end
