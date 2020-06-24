RSpec.describe 'ConfirmPayment', type: :feature do
  let(:confirm_page) { ConfirmOrderPrism.new }
  let!(:user) { create(:user, :with_credit_card) }
  let!(:deliveries) { create_list(:delivery, 2) }
  let(:valid_payment_params) { attributes_for(:credit_card) }
  let(:edit_link) { I18n.t('checkout.confirm.edit') }

  before do
    sign_in user
    create(:book)
    visit root_path
    click_on(I18n.t('home.buy_now'))
    Order.first.update!(step: :confirm)
    Order.first.update!(delivery: deliveries.first)
    Order.first.create_billing_address!(attributes_for(:address))
    Order.first.create_shipping_address!(attributes_for(:address))
    confirm_page.load
  end

  describe 'EDIT' do
    context 'when user click edit billing_addess link' do
      it 'return user to address step view ' do
        expect(Order.first.step).to eq('confirm')
        within confirm_page.billing_info do
          click_on(edit_link)
        end
        expect(confirm_page).to have_current_path checkout_path(:address)
        expect(Order.first.step).to eq('confirm')
      end
    end

    context 'when user click edit shipping_addess link' do
      it 'return user to address step view ' do
        expect(Order.first.step).to eq('confirm')
        within confirm_page.shipping_info do
          click_on(edit_link)
        end
        expect(confirm_page).to have_current_path checkout_path(:address)
        expect(Order.first.step).to eq('confirm')
      end
    end

    context 'when user click edit delivery link' do
      it 'return user to delivery step view ' do
        expect(Order.first.step).to eq('confirm')
        within confirm_page.delivery_info do
          click_on(edit_link)
        end
        expect(confirm_page).to have_current_path checkout_path(:delivery)
        expect(Order.first.step).to eq('confirm')
      end
    end

    context 'when user click edit payment link' do
      it 'return user to payment step view' do
        expect(Order.first.step).to eq('confirm')
        within confirm_page.payment_info do
          click_on(edit_link)
        end
        expect(confirm_page).to have_current_path checkout_path(:payment)
        expect(Order.first.step).to eq('confirm')
      end
    end
  end

  context 'when order :step=confirm' do
    it 'can return to previous step,status do not changed' do
      expect(Order.first.step).to eq('confirm')
      visit checkout_path(:payment)
      expect(confirm_page).to have_current_path checkout_path(:payment)
      expect(Order.first.step).to eq('confirm')
    end

    it 'impossible to go to the next step until it completes the current step' do
      expect(Order.first.step).to eq('confirm')
      visit checkout_path(:complete)
      expect(confirm_page).to have_current_path checkout_path(:confirm)

      expect(Order.first.step).to eq('confirm')
    end
  end
end
