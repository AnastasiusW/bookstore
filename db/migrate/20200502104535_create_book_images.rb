class CreateBookImages < ActiveRecord::Migration[6.0]
  def change
    create_table :book_images do |t|
      t.string :image
      t.references :book, foreign_key: true, index: true
      t.timestamps
    end
  end
end
