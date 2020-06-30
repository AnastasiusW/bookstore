class OrderPage < SitePrism::Page
  set_url '/orders'
  elements  :sort_id, '#order_sort_id'
  elements  :number_order, '.general-order-number', visible: false
end
