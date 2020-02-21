BOOKS_COUNT = 50
DIMENSION = (1.0..10.0).freeze
MATERIALS = ['Faux leather', 'Paperback', 'Fabric binding', 'Glossy paper'].freeze

after :authors, :categories do

BOOKS_COUNT.times do
    Book.create! do |book|
      book.title        = FFaker::Book.unique.title
      book.description  = FFaker::Book.description(rand(4..10))
      book.price        = rand(5.0..500.00)
      book.quantity     = rand(0..10)
      book.width  = rand(DIMENSION).floor(2)
      book.height = rand(DIMENSION).floor(2)
      book.depth  = rand(DIMENSION).floor(2)
      book.year         = rand(1900..2020)
      book.material   = MATERIALS.sample(rand(1..3)).join(', ')
      book.category_id   = Category.all.sample.id
      book.authors      = Author.all.sample(rand(1..2))
    end
  end
end
