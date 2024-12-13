module Presenters
  class Home
    def initialize
      @best_sellers = Queries::Home::Index.call
    end

    def latest_books
      BookDecorator.decorate_collection(Book.latest)
    end

    def best_sellers
      BookDecorator.decorate_collection(@best_sellers)
    end
  end
end
