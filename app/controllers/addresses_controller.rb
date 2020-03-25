class AddressesController < ApplicationController

    def create
        address_form = AddressForm.new(address_params)
        if address_form.save(current_user)
            flash[:notice] = t('notification.success.address.update', type: address_params[:type])
        else
            flash[:alert] = t('notification.fail.address.update', type: address_params[:type])
        end
    end


    def update
        address_form = AddressForm.new(address_params)
        if address_form.save(current_user)
            flash[:notice] = t('notification.success.address.update', type: address_params[:type])
        else
            flash[:alert] = t('notification.fail.address.update', type: address_params[:type])
        end
    end


    def address_params
        params.require(:billing_address || :shipping_address).permit(:first_name, :last_name, :country, :city, :address, :zip, :phone, :type)
    end
end
