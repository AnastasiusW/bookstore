class ApplicationController < ActionController::Base
  before_action :header_display
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  helper_method :current_order

  def header_display
    @presenter_header = Presenters::Header.new
  end

  def current_order
    order = Services::Orders::ChooseOrder.new(session[:order_id], current_user).call
    session[:order_id] = order.id
    order
  end

  private

  def user_not_authorized
    flash[:alert] = I18n.t('pundit.errors.user.warning')
    redirect_to(request.referrer || root_path)
  end
end
