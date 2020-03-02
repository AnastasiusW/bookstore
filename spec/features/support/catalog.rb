class Catalog < SitePrism::Page
    elements  :category_title_link, '.filter-link'
    elements  :sort_id, '#sort_id'
    elements  :title_books, '.title'
    elements  :link_books, 'a.thumb-hover-link'
    elements  :book_eye, '.fa-eye'
end
