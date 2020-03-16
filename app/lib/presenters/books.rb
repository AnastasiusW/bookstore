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
      Queries::Books::SortOrder::SORTING_LIST[prepare_sort_order]
    end

    def books_sorting_list
      Queries::Books::SortOrder::SORTING_LIST
    end

    def count_of_book
      Book.count
    end

    private

    def prepare_sort_order
      (@sort_order || Queries::Books::SortOrder::DEFAULT_ORDER).to_sym
    end
  end
end
