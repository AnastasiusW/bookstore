class BooksController < ApplicationController
    before_action :set_filter

    def index
        @categories = Category.all
        @order_param = params[:sort_by] || Book::DEFAULT_ORDER
        filter_result = SetFilterSortQuery.call(category_id: params[:category_id], sort_param: params[:sort_by]).page(params[:page]).per(Book::BOOKS_PER_PAGE)
        @books = BookDecorator.decorate_collection(filter_result)
    end

    def show

        @book=Book.find(params[:id]).decorate

    end


    private

    def set_filter
        @filter = Book::FILTERS.include?(params[:filter]) ? params[:filter] : Book::DEFAULT_FILTER
    end

end
