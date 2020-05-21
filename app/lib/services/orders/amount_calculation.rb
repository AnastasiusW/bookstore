module Services
  module Orders
    class AmountCalculation
      def initialize(order_id)
        @order_id = order_id
        @current_order = Order.find_by(id: @order_id)
      end

      def call
        recount_total_price_order if @current_order.line_items.exists?
      end

      private

      def recount_total_price_order
        recount = recount_subtotal_price_order - calculate_discount - delivery_price
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
        return 0 unless @current_order.coupon&.discount_amount

        @current_order.subtotal_price * @current_order.coupon.discount_amount / 100
      end

      def delivery_price
        @current_order.delivery ? @current_order.delivery.price : 0
      end
    end
  end
end
