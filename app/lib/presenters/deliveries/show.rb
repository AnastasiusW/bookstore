module Presenters
  module Deliveries
    class Show
      def initialize(current_order:)
        @current_order = current_order
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
