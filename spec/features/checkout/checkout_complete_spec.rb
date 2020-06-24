RSpec.describe 'ConfirmPayment', type: :feature do
  let!(:user) { create(:user, :with_credit_card) }
  let!(:deliveries) { create_list(:delivery, 2) }
  let(:valid_payment_params) { attributes_for(:credit_card) }
  let(:complete_page) { CompleteOrderPrism.new }

  before do
    sign_in user
    create(:book)
    visit root_path
    click_on(I18n.t('home.buy_now'))
    Order.first.update!(step: :complete)
    Order.first.update!(delivery: deliveries.first)
    Order.first.create_billing_address!(attributes_for(:address))
    Order.first.create_shipping_address!(attributes_for(:address))
    complete_page.load
  end

  context 'when click to :back_to transfer to catalog' do
    it 'when load view complete status and step are changed' do
      expect(Order.first.step).to eq('finish')
      expect(Order.first.status).to eq('in_queue')
      complete_page.checkout_compete_button.click
      expect(complete_page).to have_current_path books_path
      expect(Order.first.step).to eq('finish')
      expect(Order.first.status).to eq('in_queue')
    end
  end

  context 'when cannot restart the twice completed step because: the status is set to: in_queue and the session is cleared on the first visit  step :comlete' do
    it 'load view complete status and step are changed' do
      expect(Order.first.step).to eq('finish')
      expect(Order.first.status).to eq('in_queue')
      visit checkout_path(:complete)
      expect(complete_page.flash_fail_message).to have_content(I18n.t('checkout.alert.cart_empty'))
      expect(complete_page).to have_current_path order_line_items_path(Order.second)
      expect(Order.first.step).to eq('finish')
      expect(Order.first.status).to eq('in_queue')
    end
  end
end
