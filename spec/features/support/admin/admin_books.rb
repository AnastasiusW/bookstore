class AdminBooksPrism < SitePrism::Page
  element :book_title, "input[name='book[title]']"
  element :book_description, "textarea[name='book[description]']"
  element :book_year, "input[name='book[year]']"
  element :book_price, "input[name='book[price]']"
  element :book_width, "input[name='book[width]']"
  element :book_height, "input[name='book[height]']"
  element :book_depth, "input[name='book[depth]']"
  element :book_material, "input[name='book[material]']"

  def fill_form(book_new, book_exist)
    book_title.set(book_new.title)
    select(book_exist.category.title, from: 'book_category_id')
    check("#{book_exist.authors.first.first_name} #{book_exist.authors.first.last_name}")
    book_description.set(book_new.description)
    book_year.set(book_new.year)
    book_price.set(book_new.price)
    book_width.set(book_new.width)
    book_height.set(book_new.height)
    book_depth.set(book_new.depth)
    book_material.set(book_new.material)
    first('input[type=submit]').click
  end
end
