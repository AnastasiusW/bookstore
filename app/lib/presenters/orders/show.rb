module Presenters
  module Orders
    class Show

      def initialize(current_order:)
        @current_order = current_order
      end

      def billing_address
        @current_order.billing_address.decorate
      end


      def shipping_address
        @current_order.shipping_address.decorate
      end

      def payment
        @current_order.user.credit_card
      end

      def delivery
        @current_order.delivery
      end

      def items
        LineItemDecorator.decorate_collection(@current_order.line_items.order('created_at DESC'))
      end


      def presenter_item
        @presenter_items = Presenters::LineItems::Index.new(@current_order)
      end

    end
  end
end
