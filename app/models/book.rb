class Book < ApplicationRecord
  LATEST_BOOK_COUNT = 3
  MIN_PRICE = 5
  MIN_DIMENTION = 1

  belongs_to :category
  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books
  has_many :reviews, dependent: :destroy

  validates :title, :description, :price, :year, :quantity, presence: true
  validates :price, numericality: { greater_than_or_equal_to: MIN_PRICE }
  validates :height, :width, :depth, numericality: { greater_than_or_equal_to: MIN_DIMENTION }

  scope :newest, -> { order('created_at DESC') }
  scope :by_title_asc, -> { order('title ASC') }
  scope :by_title_desc, -> { order('title DESC') }
  scope :by_price_asc, -> { order('price ASC') }
  scope :by_price_desc, -> { order('price DESC') }
  scope :popular, -> { order('created_at DESC') }
  scope :category_filter, ->(category_id) { where('category_id=?', category_id) }
  scope :latest, -> { order('created_at DESC').limit(LATEST_BOOK_COUNT) }
end
