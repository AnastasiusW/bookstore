class AddIndexToOrders < ActiveRecord::Migration[6.0]
  def change
    add_index :orders, :number, unique: true
  end
end
