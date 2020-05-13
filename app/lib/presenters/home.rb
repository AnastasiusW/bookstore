module Presenters
  class Home
    def latest_books
      BookDecorator.decorate_collection(Book.latest)
    end
  end
end
