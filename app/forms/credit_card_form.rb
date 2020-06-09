class CreditCardForm
  include ActiveModel::Model
  include Virtus.model

  VALIDATE_CARD_NAME = /\A[[a-z][A-Z][\s]]+\z/.freeze
  VALIDATE_CVV = /\A[a-zA-Z]*\z/.freeze
  VALIDATE_EXPIRATION_DATE= /\A^(0[1-9]|1[0-2])\/{1}([0-9]{2})$\z/.freeze

  LENGTH_CVV = (3..4).freeze
  LENGTH_CARD_NAME = 50

  attribute :card_name, String
  attribute :number, String
  attribute :cvv, String
  attribute :expiration_date, String
  attribute :user_id, Integer

  validates :card_name, :number, :cvv, :expiration_date, presence: true

  validates :number, numericality: { only_integer: true}
  validates :card_name, length: { maximum: LENGTH_CARD_NAME},format: { with: VALIDATE_CARD_NAME }
  validates :cvv, length: { in: LENGTH_CVV},numericality: { only_integer: true}
  validates :expiration_date, format: { with: VALIDATE_EXPIRATION_DATE }

  def save(instance)
    return false unless valid?
    instance.credit_card ? instance.credit_card.update!(attributes) : CreditCard.create!(attributes)
  end

end
