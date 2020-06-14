class PaymentOrderPrism < SitePrism::Page
  set_url '/checkout/payment'


  element :flash_success, '#flash_success_id'
  element :flash_fail, '#flash_fail_id'
  element :payment_submit_button, '#checkout_payment_button'
  element :payment_number, "input[name='order[payment][number]']"
  element :payment_card_name, "input[name='order[payment][card_name]']"
  element :expiration_date, "input[name='order[payment][expiration_date]']"
  element :cvv, "input[name='order[payment][cvv]']"

  def fill_in_payment_form(payment)
    payment_number.set(payment[:number])
    payment_card_name.set(payment[:card_name])
    expiration_date.set(payment[:expiration_date])
    cvv.set(payment[:cvv])

end

  def flash_success_message
    flash_success.text
  end

  def flash_fail_message
    flash_fail.text
  end
end
