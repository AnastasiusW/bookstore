class HomePage < SitePrism::Page
  set_url '/'
  element :flash_success, '#flash_success_id'
  elements  :link_books, 'a.thumb-hover-link', visible: false
  elements  :book_eye, '.fa-eye', visible: false
  elements  :shopping_cart, '.fa-shopping-cart', visible: false
  def flash_success_message
    flash_success.text
  end
end
