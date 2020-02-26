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
      Queries::Books::SortOrder::SORTING_LIST[@order_param&.to_sym]
    end

    def books_sorting_list
      Queries::Books::SortOrder::SORTING_LIST
    end

    private

    def sort_order_nil?
      return @order_param = Queries::Books::SortOrder::DEFAULT_ORDER if @order_param.nil?
    end
  end
end
