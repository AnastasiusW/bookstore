class ApplicationController < ActionController::Base
  before_action :header_display
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  helper_method :current_order

  def header_display
    @presenter_header = Presenters::Header.new
  end

  def current_order
    Order.find_by(id: session[:order_id]) || Order.create
  end

  private

  def user_not_authorized
    flash[:alert] = I18n.t('pundit.errors.user.warning')
    redirect_to(request.referrer || root_path)
  end
end
