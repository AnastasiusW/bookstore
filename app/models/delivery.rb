class Delivery < ApplicationRecord
  has_many :order, dependent: :nullify
end
