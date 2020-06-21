class AddDetailsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :subtotal_price, :decimal, precision: 10, scale: 2, default: 0.0
    add_column :orders, :total_price, :decimal, precision: 10, scale: 2, default: 0.0
    add_column :orders, :number, :string
  end
end
