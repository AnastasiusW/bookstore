RSpec.describe AddressForm, type: :model do
  let!(:address_form) { described_class.new(params:address_params, current_instance: user) }
  let!(:user) { create(:user) }

  context 'when presence validations' do
    let!(:address_params) {
      {
        first_name: 'Nastya',
        last_name: 'Dnepr',
        country: 'UA',
        address: 'Polya',
        zip: '49000',
        phone: '+380977777777'
      }
    }

    it { expect(address_form).to validate_presence_of(:first_name) }
    it { expect(address_form).to validate_presence_of(:last_name) }
    it { expect(address_form).to  validate_presence_of(:country) }
    it { expect(address_form).to  validate_presence_of(:city) }
    it { expect(address_form).to  validate_presence_of(:address) }
    it { expect(address_form).to  validate_presence_of(:zip) }
    it { expect(address_form).to  validate_presence_of(:phone) }
  end

  context 'when input valid data' do
    let!(:address_params) {
      {
        first_name: 'Nastya',
        last_name: 'Dnepr',
        country: 'UA',
        address: 'Polya',
        zip: '49000',
        phone: '+380977777777'
      }
    }

    it 'when user input valid data' do
      address_params.each do |key, value|
        expect(address_form).to allow_value(value).for(key.to_sym)
      end

    end

  end

  context 'when input invalid data' do
    let!(:address_params) {
      {
        first_name: '11111',
        last_name: '1111',
        country: '11',
        address: '',
        zip: 'aaaa',
        phone: 'aaaa'
      }
    }


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
      expect(user.billing_address.first_name).to eq address_params[:first_name]
      expect(user.billing_address.last_name).to eq address_params[:last_name]
      expect(user.billing_address.city).to eq address_params[:city]
      expect(user.billing_address.country).to eq address_params[:country]
      expect(user.billing_address.zip).to eq address_params[:zip]
      expect(user.billing_address.phone).to eq address_params[:phone]
    end


    it 'when billing address save with fail' do
      allow(address_form).to receive(:valid?).and_return(false)
      address_form.save
      expect(user.billing_address).to eq nil
    end

  end
end
