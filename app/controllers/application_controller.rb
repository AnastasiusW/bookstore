class ApplicationController < ActionController::Base
  private

  def save_my_previous_url
    session[:my_previous_url] = request.referer
  end
end
