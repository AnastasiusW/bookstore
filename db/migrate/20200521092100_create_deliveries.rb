class CreateDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveries do |t|
      t.string :method
      t.string :from_time
      t.string :to_time
      t.decimal :price, precision: 10, scale:2

      t.timestamps
    end
  end
end
