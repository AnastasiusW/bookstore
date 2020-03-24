class AddressForm
  include ActiveModel::Model
  include Virtus

  VALIDATE_NAME = /\A[a-zA-Z]*\z/.freeze
  VALIDATE_CITY = /\A[a-zA-Z]*\z/.freeze
  VALIDATE_COUNTRY = /\A[a-zA-Z]*\z/.freeze

  VALIDATE_ADDRESS = /\A[a-zA-Z0-9 \-\,]*\z/.freeze
  VALIDATE_ZIP = /\A[0-9\-]*\z/.freeze
  VALIDATE_PHONE = /\A\+[0-9]*\z/.freeze

  LENGTH_COMMON = 50
  LENGTH_ZIP = 10
  LENGTH_PHONE = 15

  attribute :first_name, String
  attribute :last_name, String
  attribute :address, String
  attribute :city, String
  attribute :zip, Integer
  attribute :country, String
  attribute :phone, String
  attribute  :type_address, String

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true
  validates :first_name, :last_name, length: { maximum: LENGTH_COMMON }, format: { with: VALIDATE_NAME}
  validates :city, :country, length: { maximum: LENGTH_COMMON }, format: { with: VALIDATE_CITY}
  validates :country, length: { maximum: LENGTH_COMMON }, format: { with: VALIDATE_COUNTRY}
  validates :address, length: { maximum: LENGTH_COMMON }, format: { with: VALIDATE_ADDRESS}
  validates :zip, length: { maximum: LENGTH_ZIP }, format: { with: VALIDATE_ZIP }
  validates :phone, length: { maximum: LENGTH_PHONE }, format: { with: VALIDATE_PHONE }

  def save(current_instance)
    return false unless valid?
    create_or_update(current_instance)
  end

  def create_or_update(current_instance)
    if type_address == 'billing_address'
      puts type_address
    end

  end

end
