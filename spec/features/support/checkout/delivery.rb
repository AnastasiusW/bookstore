class DeliveryOrderPrism < SitePrism::Page
  set_url '/checkout/delivery'


  element :flash_success, '#flash_success_id'
  element :flash_fail, '#flash_fail_id'
  element :delivery_submit_button, '#checkout_delivery_button'


  def flash_success_message
    flash_success.text
  end

  def flash_fail_message
    flash_fail.text
  end
end
