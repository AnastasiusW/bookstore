class CheckoutController < ApplicationController
  include Wicked::Wizard
  before_action :validate_checkout

  steps :address

  def show
    render_wizard
  end

  def validate_checkout
    return authenticate_user unless user_signed_in?
  end

  def authenticate_user
    redirect_to new_quick_registration_path
  end

end
