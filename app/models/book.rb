class Book < ApplicationRecord
    belongs_to :category
    has_many :authors_books, dependent: :destroy
    has_many :authors, through: :authors_books

    validates :title, :description, :price, :year, :quantity, presence: true
    validates :price, numericality: { greater_than: 0 }
    validates :height, :width, :depth, numericality: { greater_than: 0 }

end
