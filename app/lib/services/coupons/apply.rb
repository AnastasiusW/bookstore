module Services
  module Coupons
    class Apply
      def initialize(order:, params:)
        @current_order = order
        @code = params[:code]
      end

      def call
        current_coupon = find_coupon_by_code
        current_coupon ? apply_coupon_to_order(current_coupon) : false
      end

      private

      def find_coupon_by_code
        Coupon.find_by(code: @code, active: true)
      end

      def apply_coupon_to_order(current_coupon)
        Order.update(coupon: current_coupon)
        Coupon.find_by(id: current_coupon).update(active: false)
        Services::Orders::AmountCalculation.new(@current_order).call
      end
    end
  end
end
