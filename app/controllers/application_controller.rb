class ApplicationController < ActionController::Base
  before_action :header_display

  def header_display
    @presenter_header = Presenters::Header.new
  end
end
