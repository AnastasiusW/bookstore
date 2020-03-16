class CreateAuthorsBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :authors_books do |t|
      t.references :book, foreign_key: true, index: true
      t.references :author,  foreign_key: true, index: true
    end
  end
end
