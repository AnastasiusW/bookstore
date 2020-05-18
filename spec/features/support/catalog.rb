class CatalogPage < SitePrism::Page
  set_url '/books'
  elements  :category_title_link, '.filter-link'
  elements  :sort_id, '#sort_id'
  elements  :title_books, '.title'
  elements  :link_books, 'a.thumb-hover-link'
  elements  :book_eye, '.fa-eye'
  elements   :shopping_cart, '.fa-shopping-cart'
end
