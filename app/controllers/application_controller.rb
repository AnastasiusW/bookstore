class ApplicationController < ActionController::Base
  before_action :header_display
  before_action :store_user_location!, if: :storable_location?
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

  def pundit_user
    CurrentContext.new(current_user, current_order)
  end

  private

  def user_not_authorized
    flash[:alert] = I18n.t('pundit.errors.user.warning')
    redirect_to(request.referrer || root_path)
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end
end
