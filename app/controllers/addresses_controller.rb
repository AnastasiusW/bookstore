class AddressesController < ApplicationController
  def create
    address_form = AddressForm.new(address_params)
    choose_strategy(address_form)
  end

  def update
    address_form = AddressForm.new(address_params)
    choose_strategy(address_form)
  end

  def address_params
    if params[:billing_address]
      params.require(:billing_address).permit(:first_name, :last_name, :country, :city, :address, :zip, :phone, :type)
    else
      params.require(:shipping_address).permit(:first_name, :last_name, :country, :city, :address, :zip, :phone, :type)
    end
  end

  private

  def choose_strategy(address_form)
    if address_form.save(current_user)
      flash[:notice] = t('notification.success.address.update', type: address_params[:type])
    else
      flash[:alert] = address_form.errors.full_messages.to_sentence
    end
    redirect_to edit_user_path(current_user)
  end
end
