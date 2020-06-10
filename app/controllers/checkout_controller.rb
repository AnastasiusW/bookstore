class CheckoutController < ApplicationController
  include Wicked::Wizard
  before_action :validate_checkout

  steps :address, :delivery, :payment, :confirm, :complite

  def show
    @checkout = Services::Checkout::Show.new(order: current_order, params: nil)
    @checkout.call(step)
    render_wizard
  end

  def update
    return redirect_to checkout_path(step),alert: I18n.t('checkout.alert.fail') unless params[:order] || step == :confirm
    @checkout = Services::Checkout::Update::Update.new(order: current_order,params: order_params)


   if @checkout.call(step)
      flash[:notice] = 'Success'
      redirect_to next_wizard_path
    else
      redirect_to checkout_path(step), alert: I18n.t('checkout.alert.fail')
    end
  end

  def validate_checkout
    return back_to_cart if current_order.line_items.blank?
    return authenticate_user unless user_signed_in?

  end

  def back_to_cart
    redirect_to order_line_items_path(current_order), alert: t('checkout.alert.cart_empty')
  end

  def authenticate_user
    redirect_to new_quick_registration_path
  end

  def order_params
    params.require(:order) if params[:order]
  end

end
