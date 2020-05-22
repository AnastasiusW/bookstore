class Delivery < ApplicationRecord
  has_many :orders, dependent: :nullify
end
