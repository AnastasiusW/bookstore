module Services
  module Checkout
    module Address
      class Update
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

        private

        def save_addresses
          ActiveRecord::Base.transaction do
            @form_billing = AddressForm.new(params: @order_billing_address, current_instance: @current_order).save
            @form_shipping = AddressForm.new(params: @order_shipping_address, current_instance: @current_order).save
            @current_order.update!(use_billing_address: @use_billing_address)
            raise ActiveRecord::Rollback unless @form_billing && @form_shipping

            true
          end
        end
      end
    end
  end
end
