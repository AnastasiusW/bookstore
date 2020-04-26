class ApplicationController < ActionController::Base
  before_action :header_display
  include Pundit

  def header_display
    @presenter_header = Presenters::Header.new
  end
end
