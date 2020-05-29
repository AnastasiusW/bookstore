class LineItem < ApplicationRecord
  MIN_QUANTITY = 1
  belongs_to :order, optional: true
  belongs_to :book
  validates :quantity, numericality: { greater_than_or_equal_to: MIN_QUANTITY}

end
