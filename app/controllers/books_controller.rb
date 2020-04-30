class BooksController < ApplicationController
  include Pagy::Backend
  BOOKS_PER_PAGE = 12

  def index
    filtered_books = Queries::Books::Index.new(category_id: book_params[:category_id]).call
    sorted_books = Queries::Books::SortOrder.new(collection: filtered_books, sort_param: book_params[:sort_by]).call
    @pagy, @books = pagy_countless(sorted_books, link_extra: 'data-remote="true"', items: BOOKS_PER_PAGE)
    @presenter = Presenters::Books::Index.new(books: @books, sort_order: book_params[:sort_by])
  end

  def show
    book = Book.find_by(id: book_params[:id]).decorate
    @presenter_book = Presenters::Books::Show.new(current_book: book)
  end

  private

  def book_params
    params.permit(:id, :category_id, :sort_by)
  end
end
