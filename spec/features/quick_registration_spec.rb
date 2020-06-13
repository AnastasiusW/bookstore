RSpec.describe 'QuickRegistration', type: :feature do
  let(:registration_page) { QuickRegistrationPage.new }

  before do
    create(:book)
    visit root_path
    click_on(I18n.t('home.buy_now'))
    registration_page.load
  end

  context 'when user is exist and not signed' do
    let!(:user) { create(:user) }

    it 'user will signed and has message success' do
      registration_page.fill_in_form_user_with_password(email: user.email, password: user.password)
      expect(registration_page).to have_current_path checkout_path(:address)
      expect(registration_page.flash_success_message).to have_content(I18n.t('devise.sessions.signed_in'))
    end
  end

  context 'when guest' do
    it 'inputs invalid email,user is created and redirected to checkout' do
      registration_page.fill_in_form_user_without_password(email: FFaker::Internet.email)

      expect(registration_page).to have_current_path(checkout_path(:address))
      expect(registration_page.flash_success_message).to have_content(I18n.t('checkout.login.success'))
    end

    it 'inputs invalid email,user is not created and has fail message' do
      registration_page.fill_in_form_user_without_password(email: nil)
      expect(registration_page.flash_fail_message).to have_content(I18n.t('test_error.quick_registration'))

      expect(registration_page.page).to have_current_path new_quick_registration_path
    end
  end
end
