CATEGORIES_BOOKS = ['Mobile development', 'Photo', 'Web design', 'Web development'].freeze


CATEGORIES_BOOKS.each {|category| Category.create!(title: category)}
