RSpec.describe 'Sign in', type: :feature do
  let!(:user) { create(:user) }
  let(:sign_in_page) { SignInPrism.new }
  let(:home_page) { HomePage.new }

  before do
    sign_in_page.load
  end

  context 'when try sign in with valid data' do
    let(:sucessful_sign_in) { I18n.t('devise.sessions.signed_in') }

    it 'when try sign in exist user' do
      sign_in_page.sign_in(user.email, user.password)
      expect(sign_in_page).to have_current_path(root_path)
      expect(home_page).to have_content(user.email)
      expect(home_page.flash_success_message).to have_content(I18n.t('devise.sessions.signed_in'))
    end
  end

  context 'with invalid data' do
    let(:invalid_email) { 'wrong@gmail.com' }
    let(:invalid_password) { 'wrong_password' }

    it 'shows an error message when invalid email' do
      sign_in_page.sign_in(invalid_email, user.password)
      expect(sign_in_page.flash_fail_message).to have_content(I18n.t('test_error.invalid_sign_in'))
      expect(sign_in_page).to have_current_path(new_user_session_path)
    end

    it 'shows an error message when invalid password' do
      sign_in_page.sign_in(user.email, invalid_password)
      expect(sign_in_page.flash_fail_message).to have_content(I18n.t('test_error.invalid_sign_in'))
      expect(sign_in_page).to have_current_path(new_user_session_path)
    end
  end

  context 'when user forgot password' do
    it 'when click to forgot password link' do
      click_link(I18n.t('authentication.forgot_password'))
      expect(sign_in_page).to have_current_path(new_user_password_path)
    end
  end

  context 'when click facebook icon ' do
    it 'when click icon and login success' do
      sign_in_page.valid_data_facebook
      sign_in_page.facebook_icon.click
      expect(home_page).to have_content(I18n.t('devise.omniauth_callbacks.success', kind: 'Facebook'))
      expect(home_page).to have_current_path(root_path)
    end
  end
end
