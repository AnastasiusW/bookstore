class AddressesController < ApplicationController

    def create

        address_form = AddressForm.new(address_params)
        binding.pry
        if address_form.save(current_user)
            flash[:notice] = t('notification.success.address.update', type: address_params[:type])
        else
            flash[:alert] = address_form.errors.full_messages.to_sentence
        end
    end


    def update

        address_form = AddressForm.new(address_params)
        binding.pry
        if address_form.save(current_user)
            flash[:notice] = t('notification.success.address.update', type: address_params[:type])
        else
            flash[:alert] = address_form.errors.full_messages.to_sentence
        end
    end


    def address_params
        params.require(:billing_address || :shipping_address).permit(:first_name, :last_name, :country, :city, :address, :zip, :phone, :type)
    end
end
