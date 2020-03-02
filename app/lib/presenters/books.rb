module Presenters
  class Books
    def initialize(books:, sort_order:)
      @books = books
      @sort_order = sort_order
    end

    def categories
      Category.all
    end

    def books
      BookDecorator.decorate_collection(@books)
    end

    def selected_order
      sort_order_nil?
      Queries::Books::SortOrder::SORTING_LIST[@sort_order&.to_sym]
    end

    def books_sorting_list
      Queries::Books::SortOrder::SORTING_LIST
    end

    def count_of_book
      Book.count
    end


    private

    def sort_order_nil?
      return  @sort_order = Queries::Books::SortOrder::DEFAULT_ORDER if  @sort_order.nil?
    end
  end
end
