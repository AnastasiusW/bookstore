class HomeController < ApplicationController
  def index
    @latest_books = BookDecorator.decorate_collection(Book.latest)
  end
end
