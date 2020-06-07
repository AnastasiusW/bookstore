module Services
  module Checkout
    module Update
      class Update
        def initialize(order:, params:)
          @current_order = order
          @order_params = params

        end

        def call(step)
          case step
          when :address then manage_address
          when :delivery then manage_delivery
          end
        end

        def manage_address
          Services::Checkout::Update::Address.new(order: @current_order, billing: address_billing_params, shipping: address_shipping_params, use_billing: use_billing_address_params).call

        end

        def manage_delivery
          Services::Checkout::Update::Delivery.new(order: @current_order,delivery_params: delivery_params).call

        end

        def address_billing_params
          @order_params.require(:billing).permit(*allowed_attributes)
        end

        def address_shipping_params
          @order_params.require(:shipping).permit(*allowed_attributes)
        end

        def allowed_attributes
          %w[first_name last_name country city address zip phone type]
        end

        def use_billing_address_params
          @order_params.permit(:use_billing_address)
        end

        def delivery_params
         return @order_params.permit(:delivery_id)
        end


      end
    end
  end
end
