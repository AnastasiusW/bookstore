class AddressPrivacyPrism < SitePrism::Page
  set_url '/users{/user_id}/edit'
  element :billing_first_name, "input[name='billing_address[first_name]']"
  element :billing_last_name, "input[name='billing_address[last_name]']"
  element :billing_country_name, "select[name='billing_address[country]']"
  element :billing_city_name, "input[name='billing_address[city]']"
  element :billing_address_name, "input[name='billing_address[address]']"
  element :billing_zip_name, "input[name='billing_address[zip]']"
  element :billing_phone_name, "input[name='billing_address[phone]']"
  element :button_billing, '#save-billing_address'

  element :shipping_first_name, "input[name='shipping_address[first_name]']"
  element :shipping_last_name, "input[name='shipping_address[last_name]']"
  element :shipping_country_name, "select[name='shipping_address[country]']"
  element :shipping_city_name, "input[name='shipping_address[city]']"
  element :shipping_address_name, "input[name='shipping_address[address]']"
  element :shipping_zip_name, "input[name='shipping_address[zip]']"
  element :shipping_phone_name, "input[name='shipping_address[phone]']"
  element :button_shipping, '#save-shipping_address'

  element :password_current_field, "input[name='user[current_password]']"
  element :password_new_field, "input[name='user[password]']"
  element :password_confirm_field, "input[name='user[password_confirmation]']"

  element :button_save_password, '#savePassword'



  element :input_email_change,"input[name='user[email]']"
  element :button_save_email,'#saveEmail'

  element :flash_success, '#flash_success_id'
  element :flash_fail, '#flash_fail_id'
  elements :delete_account, '.checkbox-icon'
  element :button_destroy, '#destroy_button'



  def fill_billing_form(filling_address)
    billing_first_name.set(filling_address.first_name)
    billing_last_name.set(filling_address.last_name)
    billing_country_name.set(filling_address.country)
    billing_city_name.set(filling_address.city)
    billing_address_name.set(filling_address.address)
    billing_zip_name.set(filling_address.zip)
    billing_phone_name.set(filling_address.phone)
    button_billing.click
  end

  def fill_shipping_form(filling_address)
    shipping_first_name.set(filling_address.first_name)
    shipping_last_name.set(filling_address.last_name)
    shipping_country_name.set(filling_address.country)
    shipping_city_name.set(filling_address.city)
    shipping_address_name.set(filling_address.address)
    shipping_zip_name.set(filling_address.zip)
    shipping_phone_name.set(filling_address.phone)
    button_shipping.click
  end

  def change_email(new_email)
    input_email_change.set(new_email)
    button_save_email.click
  end

  def change_password(current_password, new_password)
    password_current_field.set(current_password)
    password_new_field.set(new_password)
    password_confirm_field.set(new_password)
    button_save_password.click
  end







    def flash_success_message
      flash_success.text
    end

    def flash_fail_message
      flash_fail.text
    end






  end
