class AddressesController < ApplicationController

    def create
        address_form = AddressForm(address_params)
        if address_form.save(current_user)
            flash[:notice] = t('notification.success.address.update', type: address_params[:type_address])
        else
            flash[:alert] = t('notification.fail.address.update', type: address_params[:type_address])

        end
    end

    def address_params
        params.require(:address_form).permit(:first_name, :last_name, :country, :city, :address, :zip, :phone, :type_address)
    end
end
