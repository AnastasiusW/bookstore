class SignUpPrism < SitePrism::Page
  set_url '/users/sign_up'
  element :name_email, "input[name='user[email]']"
  element :name_password, "input[name='user[password]']"
  element :name_password_confirmation, "input[name='user[password_confirmation]']"

  def sign_up(email, password, password_confirmation)
    name_email.set(email)
    name_password.set(password)
    name_password_confirmation.set(password_confirmation)
    click_button(I18n.t('authentication.sign_up'))
  end
end
