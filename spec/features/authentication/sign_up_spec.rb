RSpec.describe 'Sign up', type: :feature do
let!(:user) { create(:user) }
let(:sign_up_page) { SignUpPrism.new }
let(:home_page) { HomePage.new}

before do
  sign_up_page.load
end

context 'when try sign up valid data' do
  let(:valid_email) { FFaker::Internet.email }
  let(:valid_password) { FFaker::Internet.password }
    it 'when sign up new user' do
      sign_up_page.sign_up(valid_email, valid_password, valid_password)
      expect(sign_up_page).to have_current_path(root_path)
      expect(home_page).to have_content(valid_email)
      expect(home_page.flash_success_message).to have_content(I18n.t('devise.registrations.signed_up'))
    end
  end

  context 'when try sign up with invalid data' do
    let(:invalid_password) { '1' }
    let(:invalid_confirmation) { '2' }
    let(:email_error) { I18n.t('test_error.email_error') }
    let(:password_error) { I18n.t('test_error.password_error') }
    let(:password_confirmation_error) { I18n.t("test_error.password_confirmation_error") }


      it 'when try sign up new user with invalid data' do
        sign_up_page.sign_up(user.email, invalid_password, invalid_confirmation)
        expect(sign_up_page).to have_content(email_error)
        expect(sign_up_page).to have_content(password_error)
        expect(sign_up_page).to have_content(password_confirmation_error)
      end
    end


end
