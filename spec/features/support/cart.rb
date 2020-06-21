class CartPage < SitePrism::Page
  set_url '/'
  elements  :plus_link, '.fa-plus'
  elements  :minus_link, '.fa-minus'

  elements  :input_quantity, '.quantity-input'
  elements :link_view_book_on_image, '.cart-img-shadow'
  element :coupon_name, "input[name='code']"
  element :flash_success, '#flash_success_id'
  element :flash_fail, '#flash_fail_id'
  def flash_success_message
    flash_success.text
  end

  def flash_fail_message
    flash_fail.text
  end
end
