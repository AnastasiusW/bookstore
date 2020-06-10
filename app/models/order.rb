class Order < ApplicationRecord
  include AASM
  attr_accessor :active_admin_requested_event

  belongs_to :user, optional: true
  has_many :line_items, dependent: :destroy
  has_one :coupon, dependent: :nullify
  belongs_to :delivery, optional: true

  has_one :billing_address, class_name: 'BillingAddress', as: :addressable, dependent: :destroy
  has_one :shipping_address, class_name: 'ShippingAddress', as: :addressable, dependent: :destroy
  validates :number, uniqueness: true

  enum status: {
    in_progress: 1,
    in_queue: 2,
    in_delivery: 3,
    delivered: 4,
    canceled: 5
  }

  aasm column: :status, enum: true do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :in_queue do
      transitions from: :in_progress, to: :in_queue
    end

    event :in_delivery do
      transitions from: :in_queue, to: :in_delivery
    end

    event :delivered do
      transitions from: :in_delivery, to: :delivered
    end

    event :canceled do
      transitions from: %i[in_progress in_queue in_delivery delivered], to: :canceled
    end
  end





end
