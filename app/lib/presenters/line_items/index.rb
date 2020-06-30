module Presenters
  module LineItems
    class Index
      def initialize(order)
        @current_order = order
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

      def delivery_price
        @current_order.delivery ? @current_order.delivery.price : 0
      end

      def delivery_methods
        Delivery.all
      end

      def checked_delivery(delivery_id)
        order_delivery_exists?(delivery_id) || Delivery.first.id == delivery_id
      end

      def order_delivery_exists?(delivery_id)
        @current_order.delivery_id && @current_order.delivery_id == delivery_id
      end
    end
  end
end
