class AddressForm
  include ActiveModel::Model
  include Virtus.model

  VALIDATE_NAME = /\A[a-zA-Z]*\z/.freeze
  VALIDATE_CITY = /\A[a-zA-Z\s*]*\z/.freeze
  VALIDATE_COUNTRY = /\A[a-zA-Z\s]*\z/.freeze
  VALIDATE_ADDRESS = /\A[a-zA-Z0-9 \-\,\s]*\z/.freeze
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
  attribute :type, String

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true
  validates :first_name, :last_name, length: { maximum: LENGTH_COMMON }, format: { with: VALIDATE_NAME }
  validates :city, :country, length: { maximum: LENGTH_COMMON }, format: { with: VALIDATE_CITY }
  validates :country, length: { maximum: LENGTH_COMMON }, format: { with: VALIDATE_COUNTRY }
  validates :address, length: { maximum: LENGTH_COMMON }, format: { with: VALIDATE_ADDRESS }
  validates :zip, length: { maximum: LENGTH_ZIP }, format: { with: VALIDATE_ZIP }
  validates :phone, length: { maximum: LENGTH_PHONE }, format: { with: VALIDATE_PHONE }

  def initialize(params:, current_instance:)
    super(params)
    @current_instance = current_instance
  end

  def save
    return false unless valid?

    create_or_update
  end

  private

  def create_or_update
    case type
    when 'billing_address' then process_billing_address
    when 'shipping_address' then process_shipping_address
    end
  end

  def process_billing_address
    if billing_address_exists?
      @current_instance.billing_address.update!(address_attrs)
    else
      @current_instance.create_billing_address!(address_attrs)
    end
  end

  def process_shipping_address
    if shipping_address_exists?
      @current_instance.shipping_address.update!(address_attrs)
    else
      @current_instance.create_shipping_address!(address_attrs)
    end
  end

  def billing_address_exists?
    @current_instance.billing_address
  end

  def shipping_address_exists?
    @current_instance.shipping_address
  end

  def address_attrs
    attributes.except(:type)
  end
end
