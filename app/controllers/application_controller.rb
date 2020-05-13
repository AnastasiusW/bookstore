class ApplicationController < ActionController::Base
  before_action :header_display
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def header_display
    @presenter_header = Presenters::Header.new
  end

  private

  def user_not_authorized
    flash[:alert] = I18n.t('pundit.errors.user.warning')
    redirect_to(request.referrer || root_path)
  end
end
