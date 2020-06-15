module Services
  module Checkout
    class Show
      attr_reader :current_order, :presenter, :presenter_items, :billing_address, :shipping_address,
                  :delivery, :payment

      def initialize(order:)
        @current_order = order
        @presenter_items = Presenters::LineItems::Index.new(current_order)
      end

      def call(step)
        case step
        when :address then manage_address
        when :delivery then manage_delivery
        when :payment then manage_payment
        when :confirm then manage_confirm
        when :complete then manage_complete
        end
      end

      private

      def manage_address
        @presenter = Presenters::Address.new(current_instance: @current_order)
      end

      def manage_delivery
        @presenter = Presenters::Deliveries::Show.new(current_order: @current_order)
      end

      def manage_payment
        @presenter = Presenters::Payments::Show.new(current_order: @current_order)
      end

      def manage_confirm
        @billing_address = @current_order.billing_address.decorate
        @shipping_address = @current_order.shipping_address.decorate
        @delivery = @current_order.delivery
        @payment = @current_order.user.credit_card
      end

      def manage_complete
        @billing_address = @current_order.billing_address.decorate
        @current_order.finish! if @current_order.complete?
      end
    end
  end
end
