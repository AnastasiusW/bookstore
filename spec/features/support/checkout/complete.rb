class CompleteOrderPrism < SitePrism::Page
  set_url '/checkout/complete'


  element :flash_success, '#flash_success_id'
  element :flash_fail, '#flash_fail_id'
  element :checkout_compete_button, '#checkout_complete_button'


  def flash_success_message
    flash_success.text
  end

  def flash_fail_message
    flash_fail.text
  end
end
