module Services
  module Orders
    class RecalculateAmount
      def initialize(order_id)
        @current_order = Order.find_by(id: order_id)
      end

      def call
        return recount_total_price_order if @current_order.line_items.exists?

        reset_to_zero_price
      end

      private

      def reset_to_zero_price
        @current_order.update(total_price: 0)
        @current_order.update(subtotal_price: 0)
      end

      def recount_total_price_order
        recount = recount_subtotal_price_order + delivery_price - calculate_discount
        @current_order.update(total_price: recount)
      end

      def recount_subtotal_price_order
        @current_order.update(subtotal_price: total_sum_by_current_items)
        @current_order.subtotal_price
      end

      def total_sum_by_current_items
        @current_order.line_items.sum(:total_price)
      end

      def calculate_discount
        return 0 unless @current_order.coupon

        @current_order.subtotal_price * @current_order.coupon.discount_amount / 100
      end

      def delivery_price
        @current_order.delivery ? @current_order.delivery.price : 0
      end
    end
  end
end
