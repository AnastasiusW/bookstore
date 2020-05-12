class Coupon < ApplicationRecord
  belongs_to :order, optional: true
end
