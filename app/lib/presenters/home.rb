module Presenters
  class Home
    def initialize; end

    def latest_books
      BookDecorator.decorate_collection(Book.latest)
    end
  end
end
