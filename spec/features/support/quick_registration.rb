class QuickRegistrationPage < SitePrism::Page
  set_url '/quick_registrations/new'
  element :flash_success, '#flash_success_id'
  element :flash_fail, '#flash_fail_id'

  section :form_user_with_password, '#user_with_password' do
    element :email_with_password, "input[name='user[email]']"
    element :password_with_user, "input[name='user[password]']"
    element :button_user_with_password, '#button_user_with_password'
  end

  section :form_user_without_password, '#user_without_password' do
    element :email_without_password, "input[name='user[email]']"
    element :button_user_without_password, '#button_user_without_password'
  end

  def fill_in_form_user_with_password(email:, password:)
    form_user_with_password.email_with_password.set(email)
    form_user_with_password.password_with_user.set(password)
    form_user_with_password.button_user_with_password.click
  end

  def fill_in_form_user_without_password(email:)
    form_user_without_password.email_without_password.set(email)
    form_user_without_password.button_user_without_password.click
  end

  def flash_success_message
    flash_success.text
  end

  def flash_fail_message
    flash_fail.text
  end
end
