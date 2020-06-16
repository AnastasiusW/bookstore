class CheckoutController < ApplicationController
  include Wicked::Wizard
  before_action :validate_checkout
  after_action :checkout_complete
  steps :address, :delivery, :payment, :confirm, :complete

  def show
    return redirect_to wizard_path(current_order.step) unless control_current_step

    @checkout = Services::Checkout::Show.new(order: current_order)
    @checkout.call(step)
    render_wizard
  end

  def update
    unless params[:order] || step == :confirm
      return redirect_to checkout_path(step), alert: I18n.t('checkout.alert.fail')
    end

    @checkout = Services::Checkout::Update::Update.new(order: current_order, params: order_params)

    if @checkout.call(step)
      redirect_to next_wizard_path, notice: I18n.t('checkout.success.note')
    else
      redirect_to checkout_path(step), alert: I18n.t('checkout.alert.fail')
    end
  end

  private

  def validate_checkout
    return back_to_cart if current_order.line_items.blank?
    return authenticate_user unless user_signed_in?
  end

  def control_current_step
    Order.steps[current_order.step] >= Order.steps[@step]
  end

  def back_to_cart
    redirect_to order_line_items_path(current_order), alert: I18n.t('checkout.alert.cart_empty')
  end

  def authenticate_user
    redirect_to new_quick_registration_path
  end

  def order_params
    params.require(:order) if params[:order]
  end

  def checkout_complete
    return unless current_order.finish? && step == :complete

    current_order.in_queue!

    session.delete(:order_id)
  end
end
