class UserAddressesController < ApplicationController
  before_action :authenticate_user!
  def create
    process_address
  end

  def update
    process_address
  end

  private

  def address_params
    if params[:billing_address]
      params.require(:billing_address).permit(*allowed_attributes)
    else
      params.require(:shipping_address).permit(*allowed_attributes)
    end
  end

  def allowed_attributes
    %w[first_name last_name country city address zip phone type]
  end

  def process_address
    address_form = AddressForm.new(params:address_params, current_instance: current_user)
    if address_form.save
      flash[:notice] = t('notification.success.address.update', type: address_params[:type])
    else
      flash[:alert] = address_form.errors.full_messages.to_sentence
    end
    redirect_to edit_user_path(current_user)
  end
end
