RSpec.describe AddressForm, type: :model do
  let!(:address_form) { described_class.new(params: address_params, current_instance: user) }
  let!(:user) { create(:user) }

  context 'when presence validations' do
    let(:address_params) { attributes_for(:address, city: 'Dnepr') }

    it { expect(address_form).to validate_presence_of(:first_name) }
    it { expect(address_form).to validate_presence_of(:last_name) }
    it { expect(address_form).to  validate_presence_of(:country) }
    it { expect(address_form).to  validate_presence_of(:city) }
    it { expect(address_form).to  validate_presence_of(:address) }
    it { expect(address_form).to  validate_presence_of(:zip) }
    it { expect(address_form).to  validate_presence_of(:phone) }
  end

  context 'when input valid data' do
    let(:address_params) { attributes_for(:address, city: 'Dnepr') }

    it 'when user input valid data' do
      address_params.each do |key, value|
        expect(address_form).to allow_value(value).for(key.to_sym)
      end
    end
  end

  context 'when input invalid data' do
    let!(:address_params) do
      attributes_for(:address,
                     first_name: FFaker::Random.rand(0..9),
                     last_name: FFaker::Random.rand(0..9),
                     city: '',
                     country: FFaker::Random.rand(0..9),
                     address: '',
                     zip: FFaker::Lorem.word,
                     phone: FFaker::Lorem.word)
    end

    it 'when user input invalid data' do
      address_params.each do |key, value|
        expect(address_form).not_to allow_value(value).for(key.to_sym)
      end
    end
  end

  context 'when save form' do
    let!(:address_params) { attributes_for(:address, type: 'billing_address') }

    it 'when billing address save with success' do
      expect(BillingAddress.count).to eq(0)
      address_form.save
      expect(BillingAddress.count).to eq(1)
      %i[first_name last_name city country address zip phone].each do |key|
        expect(user.billing_address[key]).to eq address_params[key]
      end
    end

    it 'when billing address save with fail' do
      allow(address_form).to receive(:valid?).and_return(false)
      address_form.save
      expect(user.billing_address).to eq nil
    end
  end
end
