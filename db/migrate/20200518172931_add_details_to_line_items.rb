class AddDetailsToLineItems < ActiveRecord::Migration[6.0]
  def change
    add_column :line_items, :total_price, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
