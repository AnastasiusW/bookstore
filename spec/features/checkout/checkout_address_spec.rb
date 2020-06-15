RSpec.describe 'CheckoutAddress', type: :feature do
  let(:address_page) { AddressOrderPrism.new }
  let(:user) { create(:user) }
  let(:valid_address_data) { attributes_for(:address) }
  let(:valid_address_data_shipping) { attributes_for(:address) }

  before do
    sign_in user
    create(:book)
    visit root_path
    click_on(I18n.t('home.buy_now'))

    address_page.load
  end

  context 'when user input valid date for billing and shipping address' do
    it 'creates order billing and shipping address, transfer to delivery step' do
      expect(Order.first.step).to eq('address')

      expect(Order.first.billing_address).to eq(nil)
      expect(Order.first.shipping_address).to eq(nil)
      address_page.fill_in_billing_address_form(valid_address_data)
      address_page.fill_in_shipping_address_form(valid_address_data_shipping)
      address_page.button_checkout_address.click
      expect(address_page.flash_success_message).to have_content(I18n.t('checkout.success.note'))
      expect(address_page).to have_current_path checkout_path(:delivery)
      expect(Order.first.billing_address.address).to eq(valid_address_data[:address])
      expect(Order.first.shipping_address.address).to eq(valid_address_data_shipping[:address])
      expect(Order.first.step).to eq('delivery')
    end
  end

  context 'when user input valid date for billing and shipping address,transfer to delivery step' do
    it 'creates order billing and simular shiiping address if user check :use_billing_address' do
      expect(Order.first.step).to eq('address')

      expect(Order.first.billing_address).to eq(nil)
      expect(Order.first.shipping_address).to eq(nil)
      address_page.fill_in_billing_address_form(valid_address_data)
      address_page.use_billing.click
      address_page.button_checkout_address.click
      expect(address_page.flash_success_message).to have_content(I18n.t('checkout.success.note'))
      expect(address_page).to have_current_path checkout_path(:delivery)
      expect(Order.first.billing_address.address).to eq(valid_address_data[:address])
      expect(Order.first.shipping_address.address).to eq(valid_address_data[:address])
      expect(Order.first.step).to eq('delivery')
    end
  end

  context 'when user have billing and shipping address and input new valid params' do
    let(:user) { create(:user, :with_addresses) }

    it 'creates order billing and shipping address, transfer to delivery step' do
      expect(Order.first.step).to eq('address')

      expect(Order.first.billing_address).to eq(nil)
      expect(Order.first.shipping_address).to eq(nil)
      address_page.fill_in_billing_address_form(valid_address_data)
      address_page.fill_in_shipping_address_form(valid_address_data_shipping)
      address_page.button_checkout_address.click
      expect(address_page.flash_success_message).to have_content(I18n.t('checkout.success.note'))
      expect(address_page).to have_current_path checkout_path(:delivery)
      expect(Order.first.billing_address.address).to eq(valid_address_data[:address])
      expect(Order.first.shipping_address.address).to eq(valid_address_data_shipping[:address])
      expect(Order.first.step).to eq('delivery')
    end
  end

  context 'when user input invalid date for billing and shipping address' do
    let(:invalid_address_data) do
      {
        first_name: '',
        last_name: '',
        city: '',
        country: 'AF',
        address: '',
        zip: '',
        phone: ''
      }
    end

    it 'not create billing and shipping address, can not transfer to delivery step' do
      expect(Order.first.step).to eq('address')
      expect(Order.first.billing_address).to eq(nil)
      expect(Order.first.shipping_address).to eq(nil)
      address_page.fill_in_billing_address_form(invalid_address_data)
      address_page.fill_in_shipping_address_form(invalid_address_data)
      address_page.button_checkout_address.click

      expect(address_page.flash_fail_message).to have_content(I18n.t('checkout.alert.fail'))
      expect(address_page).to have_current_path checkout_path(:address)
      expect(Order.first.billing_address).to eq(nil)
      expect(Order.first.shipping_address).to eq(nil)
      expect(Order.first.step).to eq('address')
    end
  end

  context 'when order :step=address' do
    it 'impossible to go to the next step until it completes the current step' do
      expect(Order.first.step).to eq('address')
      visit checkout_path(:delivery)
      expect(address_page).to have_current_path checkout_path(:address)
      expect(Order.first.step).to eq('address')
    end
  end
end
