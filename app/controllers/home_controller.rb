class HomeController < ApplicationController
  def index
    @presenter = Presenters::Home.new
  end
end
