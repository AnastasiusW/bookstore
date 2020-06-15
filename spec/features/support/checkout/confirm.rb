class ConfirmOrderPrism < SitePrism::Page
  set_url '/checkout/confirm'

  element :shipping_info, '.shipping_info'
  element :billing_info, '.billing_info'
  element :delivery_info, '.delivery_info'
  element :payment_info, '.payment_info'
end
