class HomeController < ApplicationController
  def index
    @best_sellers = Queries::Home::Index.call
    @presenter = Presenters::Home.new(best_sellers: @best_sellers)
  end
end
