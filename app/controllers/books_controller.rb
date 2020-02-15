class BooksController < ApplicationController

    before_action :set_filter

    def index
        @books=Book.by_filter(@filter)
    end


    private

    def set_filter
        @filter = Book::FILTERS.include?(params[:filter]) ? params[:filter] : Book::DEFAULT_FILTER
    end

end
