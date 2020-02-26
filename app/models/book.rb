class Book < ApplicationRecord
  DEFAULT_ORDER = 'created_at DESC'.freeze
  BOOKS_PER_PAGE = 12
  DESCRIPTION_LIMIT = 250
  LATEST_BOOK_COUNT = 3

  belongs_to :category
  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books

  validates :title, :description, :price, :year, :quantity, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :height, :width, :depth, numericality: { greater_than: 0 }

  scope :newest, -> { order('created_at DESC') }
  scope :by_title_asc, -> { order('title ASC') }
  scope :by_title_desc, -> { order('title DESC') }
  scope :by_price_asc, -> { order('price ASC') }
  scope :by_price_desc, -> { order('price DESC') }
  scope :popular, -> { order('created_at DESC') }
  scope :category_filter, ->(category_id) { where('category_id=?', category_id) }
  scope :latest, -> { order('created_at DESC').limit(LATEST_BOOK_COUNT) }
end
