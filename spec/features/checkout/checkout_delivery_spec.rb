RSpec.describe 'CheckoutDelivery', type: :feature do
  let(:delivery_page) { DeliveryOrderPrism.new }
  let!(:user) { create(:user) }
  let!(:deliveries){create_list(:delivery,2)}

  before do
    sign_in user
    create(:book)
    visit root_path
    click_on(I18n.t('home.buy_now'))
    Order.first.update!(step: :delivery)
    delivery_page.load
  end

  context 'when user choose delivery, order have not delivery method' do

    it 'creates delivery method for order' do
      expect(Order.first.step).to eq("delivery")
      expect(Order.first.delivery).to eq(nil)
      delivery_page.delivery_submit_button.click
      expect(delivery_page.flash_success_message).to have_content(I18n.t('checkout.success.note'))
      expect(delivery_page).to have_current_path checkout_path(:payment)
      expect(Order.first.delivery.method_name).to eq(deliveries.first.method_name)
      expect(Order.first.step).to eq("payment")

    end
  end

  context 'when user choose delivery, order have not delivery method' do
    before do
      Order.first.update!(delivery: deliveries.second)
    end
    it 'updates delivery method for order' do
      expect(Order.first.step).to eq("delivery")
      expect(Order.first.delivery.method_name).to eq(deliveries.second.method_name)
      delivery_page.delivery_submit_button.click
      expect(delivery_page.flash_success_message).to have_content(I18n.t('checkout.success.note'))
      expect(delivery_page).to have_current_path checkout_path(:payment)

      expect(Order.first.delivery.method_name).to eq(deliveries.first.method_name)
      expect(Order.first.step).to eq("payment")

    end
  end

  context 'when order :step=delivery' do
    before do
      Order.first.create_billing_address!(attributes_for(:address))
      Order.first.create_shipping_address!(attributes_for(:address))
    end
    it 'can return to previous step,status do not changed' do
      expect(Order.first.step).to eq("delivery")
      visit checkout_path(:address)
      expect(delivery_page).to have_current_path checkout_path(:address)
      find('#checkout_address_button').click
      expect(delivery_page).to have_current_path checkout_path(:delivery)

      expect(Order.first.step).to eq("delivery")
    end

    it 'can not transfer to next step' do
      expect(Order.first.step).to eq("delivery")
      visit checkout_path(:payment)
      expect(delivery_page).to have_current_path checkout_path(:delivery)

      expect(Order.first.step).to eq("delivery")

    end
  end
end
