class AddressPrivacyPrism < SitePrism::Page
  set_url '/users{/user_id}/edit'

  element :flash_success, '#flash_success_id'
  element :flash_fail, '#flash_fail_id'

  class BillingAddressesSection < SitePrism::Section
    element :billing_first_name, "input[name='billing_address[first_name]']"
    element :billing_last_name, "input[name='billing_address[last_name]']"
    element :billing_country_name, "select[name='billing_address[country]']"
    element :billing_city_name, "input[name='billing_address[city]']"
    element :billing_address_name, "input[name='billing_address[address]']"
    element :billing_zip_name, "input[name='billing_address[zip]']"
    element :billing_phone_name, "input[name='billing_address[phone]']"
    element :button_billing, '#save-billing_address'
  end

  class ShippingAddressesSection < SitePrism::Section
    element :shipping_first_name, "input[name='shipping_address[first_name]']"
    element :shipping_last_name, "input[name='shipping_address[last_name]']"
    element :shipping_country_name, "select[name='shipping_address[country]']"
    element :shipping_city_name, "input[name='shipping_address[city]']"
    element :shipping_address_name, "input[name='shipping_address[address]']"
    element :shipping_zip_name, "input[name='shipping_address[zip]']"
    element :shipping_phone_name, "input[name='shipping_address[phone]']"
    element :button_shipping, '#save-shipping_address'
  end

  class AccountDetailsSection < SitePrism::Section
    element :password_current_field, "input[name='user[current_password]']"
    element :password_new_field, "input[name='user[password]']"
    element :password_confirm_field, "input[name='user[password_confirmation]']"
    element :button_save_password, '#savePassword'
    element :input_email_change, "input[name='user[email]']"
    element :button_save_email, '#saveEmail'
    elements :delete_account, '.checkbox-icon'
    element :button_destroy, '#destroy_button'
  end

  section :billing_address_section, BillingAddressesSection, '#billing_address_form'
  section :shipping_address_section, ShippingAddressesSection, '#shipping_address_form'
  section :account_detail, AccountDetailsSection, '#details_section'

  def fill_in_billing_address_form(address)
    billing_address_section.billing_first_name.set(address.first_name)
    billing_address_section.billing_last_name.set(address.last_name)
    billing_address_section.billing_country_name.set(address.country)
    billing_address_section.billing_city_name.set(address.city)
    billing_address_section.billing_address_name.set(address.address)
    billing_address_section.billing_zip_name.set(address.zip)
    billing_address_section.billing_phone_name.set(address.phone)
    billing_address_section.button_billing.click
  end

  def fill_in_shipping_address_form(address)
    shipping_address_section.shipping_first_name.set(address.first_name)
    shipping_address_section.shipping_last_name.set(address.last_name)
    shipping_address_section.shipping_country_name.set(address.country)
    shipping_address_section.shipping_city_name.set(address.city)
    shipping_address_section.shipping_address_name.set(address.address)
    shipping_address_section.shipping_zip_name.set(address.zip)
    shipping_address_section.shipping_phone_name.set(address.phone)
    shipping_address_section.button_shipping.click
  end

  def change_email(new_email)
    account_detail.input_email_change.set(new_email)
    account_detail.button_save_email.click
  end

  def change_password(current_password, new_password)
    account_detail.password_current_field.set(current_password)
    account_detail.password_new_field.set(new_password)
    account_detail.password_confirm_field.set(new_password)
    account_detail.button_save_password.click
  end

  def flash_success_message
    flash_success.text
  end

  def flash_fail_message
    flash_fail.text
  end
end
