class Book < ApplicationRecord
  LATEST_BOOK_COUNT = 3
  MIN_PRICE = 5
  MIN_DIMENTION = 1
  belongs_to :category
  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books
  has_many :reviews, dependent: :destroy
  has_many :book_images, dependent: :destroy
  has_many :line_items
  accepts_nested_attributes_for :book_images, allow_destroy: true

  validates :title, :description, :price, :year, :quantity, presence: true
  validates :price, numericality: { greater_than_or_equal_to: MIN_PRICE }
  validates :height, :width, :depth, numericality: { greater_than_or_equal_to: MIN_DIMENTION }

  scope :newest, -> { order('created_at DESC') }
  scope :by_title_asc, -> { order('title ASC') }
  scope :by_title_desc, -> { order('title DESC') }
  scope :by_price_asc, -> { order('price ASC') }
  scope :by_price_desc, -> { order('price DESC') }
  scope :popular, lambda {
                    select('books.*', 'SUM(line_items.quantity) as total')
                      .joins(:line_items)
                      .group(:id)
                      .order('total DESC')
                  }
  scope :latest, -> { order('created_at DESC').limit(LATEST_BOOK_COUNT) }
end
