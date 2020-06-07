module Services
  module Checkout
    module Update
      class Address
        def initialize(order:, billing:, shipping:, use_billing:)
          @current_order = order
          @order_billing_address = billing
          @order_shipping_address = shipping
          @use_billing_address = use_billing[:use_billing_address].to_i
        end

        def call

          if @use_billing_address == 1

            @order_shipping_address = @order_billing_address.clone
            @order_shipping_address[:type] = 'shipping_address'
          end
          save_addresses
        end

        def save_addresses

          ActiveRecord::Base.transaction do
            @form_billing = AddressForm.new(params: @order_billing_address, current_instance: @current_order).save
            @form_shipping = AddressForm.new(params: @order_shipping_address, current_instance: @current_order).save

            update_use_billing_address
            if  !@form_billing || !@form_shipping
              raise ActiveRecord::Rollback
            else
              return true
            end
          end
        end

        def update_use_billing_address
          @current_order.update!(use_billing_address: @use_billing_address)
        end
      end
    end
  end
end
