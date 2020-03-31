RSpec.describe AddressForm, type: :model do
  context 'when presence validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:zip) }
    it { is_expected.to validate_presence_of(:phone) }
  end

  context 'when input valid data' do
    let(:name_input) { 'Nastya' }
    let(:city_input) { 'Dnepr' }
    let(:country_input) { 'UA' }
    let(:address_input) { 'Polya' }
    let(:zip_input) { '49000' }
    let(:phone_input) { '+380977777777' }

    it { is_expected.to allow_value(name_input).for(:first_name) }
    it { is_expected.to allow_value(name_input).for(:last_name) }
    it { is_expected.to allow_value(country_input).for(:country) }
    it { is_expected.to allow_value(city_input).for(:city) }
    it { is_expected.to allow_value(address_input).for(:address) }
    it { is_expected.to allow_value(zip_input).for(:zip) }
    it { is_expected.to allow_value(phone_input).for(:phone) }
  end

  context 'when input invalid data' do
    let(:name_input) { '11111' }
    let(:city_input) { '1111' }
    let(:country_input) { '1111' }
    let(:address_input) { '' }
    let(:zip_input) { 'aaaa' }
    let(:phone_input) { 'aaaa' }

    it { is_expected.not_to allow_value(name_input).for(:first_name) }
    it { is_expected.not_to allow_value(name_input).for(:last_name) }
    it { is_expected.not_to allow_value(country_input).for(:country) }
    it { is_expected.not_to allow_value(city_input).for(:city) }
    it { is_expected.not_to allow_value(address_input).for(:address) }
    it { is_expected.not_to allow_value(zip_input).for(:zip) }
    it { is_expected.not_to allow_value(phone_input).for(:phone) }
  end

  context 'when save form' do
    let(:address_form) { described_class.new(Hash.new(params)) }
    let!(:user) { build(:user, :with_addresses) }
    let!(:params) { user.billing_address }

    it 'when billing address save with success' do
      address_form.save(user)
      expect(user.billing_address).to eq params
    end
  end
end
