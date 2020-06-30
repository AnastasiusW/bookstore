class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.integer :quantity, null: false, default:1
      t.decimal :width, precision: 5, scale: 1
      t.decimal :height, precision: 5, scale: 1
      t.decimal :depth, precision: 5, scale: 1
      t.integer :year
      t.string :material
      t.references :category,foreign_key: true, index: true

      t.timestamps
    end
  end
end
