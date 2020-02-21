class Book < ApplicationRecord
  DEFAULT_ORDER = 'created_at DESC'.freeze
  BOOKS_PER_PAGE = 12
  DESCRIPTION_LIMIT = 250

  SORTING_LIST = {
    "created_at DESC": I18n.t('sorting.newest_first'),
    "popular": I18n.t('sorting.popular_book'),
    "price ASC": I18n.t('sorting.price_asc'),
    "price DESC": I18n.t('sorting.price_desc'),
    "title ASC": I18n.t('sorting.title_asc'),
    "title DESC": I18n.t('sorting.title_desc')
  }.freeze

  belongs_to :category
  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books

  validates :title, :description, :price, :year, :quantity, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :height, :width, :depth, numericality: { greater_than: 0 }
end
