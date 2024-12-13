module Services
  module Checkout
    class Update
      def initialize(order:, params:)
        @current_order = order
        @order_params = params
      end

      def call(step)
        case step
        when :address then manage_address
        when :delivery then manage_delivery
        when :payment then manage_payment
        when :confirm then manage_confirm
        end
      end

      private

      def manage_address
        result = Services::Checkout::Address::Update.new(order: @current_order,
                                                         billing: address_billing_params,
                                                         shipping: address_shipping_params,
                                                         use_billing: use_billing_address_params).call

        return false unless result

        @current_order.address? ? @current_order.delivery! : result
      end

      def manage_delivery
        result = Services::Checkout::Delivery::Update.new(order: @current_order,
                                                          delivery_params: delivery_params).call
        return false unless result

        @current_order.delivery? ? @current_order.payment! : result
      end

      def manage_payment
        result = CreditCardForm.new(payment_params).save(@current_order.user)
        return false unless result

        @current_order.payment? ? @current_order.confirm! : result
      end

      def manage_confirm
        result = OrderMailer.with(user: @current_order.user).order_confirmation.deliver_now
        return false unless result

        @current_order.complete! if @current_order.confirm?
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
        @order_params.permit(:delivery_id)
      end

      def payment_params
        @order_params.require(:payment).permit(:number, :card_name, :expiration_date, :cvv, :user_id)
      end
    end
  end
end
