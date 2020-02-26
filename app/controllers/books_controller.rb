class BooksController < ApplicationController
  include Pagy::Backend

  def index
    filtered_books = Queries::Books::Index.new(category_id: params[:category_id]).call
    sorted_books = Queries::Books::SortOrder.new(collection_filtered: filtered_books, sort_param: params[:sort_by]).call
    @pagy, books = pagy(sorted_books, items: Book::BOOKS_PER_PAGE)

    @presenter = Presenters::Books.new(books: books, sort_order: params[:sort_by])
  end

  def show
    @book = Book.find(params[:id]).decorate
  end

  private

  def book_params
    params.require(:book).permit(:id, :category_id, :sort_by)
  end
end
