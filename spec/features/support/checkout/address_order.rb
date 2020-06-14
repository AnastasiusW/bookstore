class AddressOrderPrism < SitePrism::Page
  set_url '/checkout/address'


  element :flash_success, '#flash_success_id'
  element :flash_fail, '#flash_fail_id'


    element :billing_first_name, "input[name='order[billing][first_name]']"
    element :billing_last_name, "input[name='order[billing][last_name]']"
    element :billing_country_name, "select[name='order[billing][country]']"
    element :billing_city_name, "input[name='order[billing][city]']"
    element :billing_address_name, "input[name='order[billing][address]']"
    element :billing_zip_name, "input[name='order[billing][zip]']"
    element :billing_phone_name, "input[name='order[billing][phone]']"
    element :button_checkout_address, '#checkout_address_button'
    element :use_billing, '.checkbox-icon'


    element :shipping_first_name, "input[name='order[shipping][first_name]']"
    element :shipping_last_name, "input[name='order[shipping][last_name]']"
    element :shipping_country_name, "select[name='order[shipping][country]']"
    element :shipping_city_name, "input[name='order[shipping][city]']"
    element :shipping_address_name, "input[name='order[shipping][address]']"
    element :shipping_zip_name, "input[name='order[shipping][zip]']"
    element :shipping_phone_name, "input[name='order[shipping][phone]']"



  def fill_in_billing_address_form(address)
      billing_first_name.set(address[:first_name])
      billing_last_name.set(address[:last_name])
      billing_country_name.set(address[:country])
      billing_city_name.set(address[:city])
      billing_address_name.set(address[:address])
      billing_zip_name.set(address[:zip])
      billing_phone_name.set(address[:phone])
  end

  def fill_in_shipping_address_form(address)
      shipping_first_name.set(address[:first_name])
      shipping_last_name.set(address[:last_name])
      shipping_country_name.set(address[:country])
      shipping_city_name.set(address[:city])
      shipping_address_name.set(address[:address])
      shipping_zip_name.set(address[:zip])
      shipping_phone_name.set(address[:phone])
  end

  def flash_success_message
    flash_success.text
  end

  def flash_fail_message
    flash_fail.text
  end
end
