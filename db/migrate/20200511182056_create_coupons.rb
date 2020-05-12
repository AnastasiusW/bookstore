class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.string :code
      t.decimal :discount_amount, precision: 10, scale: 2, default: 0.0
      t.boolean :active, default: true
      t.references :order, foreign_key: true, index: true

      t.timestamps
    end
  end
end
