module Presenters
  module LineItems
    class Index
      def initialize(order_id)
        @order_id = order_id
        @current_order = Order.find_by(id: @order_id)
      end

      def items
        LineItemDecorator.decorate_collection(@current_order.line_items.order('created_at DESC'))
      end

      def subtotal
        @current_order.subtotal_price
      end

      def total
        @current_order.total_price
      end

      def discount_price
        calculate_discount_for_current_order
      end

      def calculate_discount_for_current_order
        return 0 unless @current_order.coupon&.discount_amount

        @current_order.subtotal_price * @current_order.coupon.discount_amount / 100
      end
    end
  end
end
