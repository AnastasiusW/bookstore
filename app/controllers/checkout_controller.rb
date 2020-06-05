class CheckoutController < ApplicationController
  include Wicked::Wizard
  before_action :validate_checkout

  steps :address

  def show
    @checkout = Services::Checkout::Show.new(order: current_order, params: nil)
    @checkout.call(step)
    render_wizard
  end

  def update
    @checkout = Services::Checkout::Update::Update.new(order: current_order,
                                                       billing: address_billing_params,
                                                       shipping: address_shipping_params,
                                                       use: use_billing_address_params)
    if @checkout.call(step)
      flash[:notice] = 'Success'
    else
      flash[:alert] = 'Fails'
    end
  end

  def validate_checkout
    return authenticate_user unless user_signed_in?
  end

  def authenticate_user
    redirect_to new_quick_registration_path
  end

  def address_billing_params
    params.require(:order).require(:billing).permit(*allowed_attributes)
  end

  def address_shipping_params
    params.require(:order).require(:shipping).permit(*allowed_attributes)
  end

  def allowed_attributes
    %w[first_name last_name country city address zip phone type]
  end

  def use_billing_address_params
    params.require(:order).permit(:use_billing_address)
  end
end
