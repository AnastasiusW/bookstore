class Book < ApplicationRecord
    FILTERS = [:newest, :price_asc, :price_desc,
               :title_asc,:title_desc ].freeze
    DEFAULT_FILTER = :filter_newest

    belongs_to :category
    has_many :authors_books, dependent: :destroy
    has_many :authors, through: :authors_books

    validates :title, :description, :price, :year, :quantity, presence: true
    validates :price, numericality: { greater_than: 0 }
    validates :height, :width, :depth, numericality: { greater_than: 0 }

    scope :newest, -> { order('created_at DESC') }
    scope :price_desc, -> { order('price DESC')}
    scope :price_asc, -> { order('price')}
    scope :by_title_asc, -> { order('title')}
    scope :by_title_desc, -> {order('title DESC')}
    scope :by_filter, -> (filter) {public_send(filter)}

end
