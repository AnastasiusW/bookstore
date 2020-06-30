RSpec.describe 'CheckoutPayment', type: :feature do
  let(:payment_page) { PaymentOrderPrism.new }
  let(:user) { create(:user) }
  let!(:deliveries) { create_list(:delivery, 2) }
  let(:valid_payment_params) { attributes_for(:credit_card) }

  before do
    sign_in user
    create(:book)
    visit root_path
    click_on(I18n.t('home.buy_now'))
    Order.first.update!(step: :payment)
    Order.first.update!(delivery: deliveries.first)
    Order.first.create_billing_address!(attributes_for(:address))
    Order.first.create_shipping_address!(attributes_for(:address))
    payment_page.load
  end

  context 'when credit cart do not exist' do
    it 'creates credit card for user, input valid params' do
      expect(Order.first.step).to eq('payment')
      expect(Order.first.user.credit_card).to eq(nil)
      payment_page.fill_in_payment_form(valid_payment_params)
      payment_page.payment_submit_button.click
      expect(payment_page.flash_success_message).to have_content(I18n.t('checkout.success.note'))
      expect(payment_page).to have_current_path checkout_path(:confirm)
      expect(Order.first.user.credit_card.number).to eq(valid_payment_params[:number])

      expect(Order.first.step).to eq('confirm')
    end
  end

  context 'when credit card exist' do
    let(:user) { create(:user, :with_credit_card) }

    it 'updates credit card, input valid params ' do
      expect(Order.first.step).to eq('payment')
      expect(Order.first.user.credit_card.number).to eq(CreditCard.first.number)
      payment_page.fill_in_payment_form(valid_payment_params)
      payment_page.payment_submit_button.click
      expect(payment_page.flash_success_message).to have_content(I18n.t('checkout.success.note'))
      expect(payment_page).to have_current_path checkout_path(:confirm)
      expect(Order.first.user.credit_card.number).to eq(valid_payment_params[:number])

      expect(Order.first.step).to eq('confirm')
    end
  end

  context 'when order :step=payment' do
    it 'can return to previous step,status do not changed' do
      expect(Order.first.step).to eq('payment')
      visit checkout_path(:delivery)
      expect(payment_page).to have_current_path checkout_path(:delivery)
      find('#checkout_delivery_button').click
      expect(payment_page).to have_current_path checkout_path(:payment)

      expect(Order.first.step).to eq('payment')
    end

    it 'impossible to go to the next step until it completes the current step' do
      expect(Order.first.step).to eq('payment')
      visit checkout_path(:confirm)
      expect(payment_page).to have_current_path checkout_path(:payment)

      expect(Order.first.step).to eq('payment')
    end
  end
end
