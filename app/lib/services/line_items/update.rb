module Services
  module LineItems
    class Update
      def initialize(allowed_params:)
        @quantity_action = allowed_params[:quantity_action]
        @current_order = allowed_params[:order_id]
        @current_item = LineItem.find_by(id: allowed_params[:id], order_id: allowed_params[:order_id])
      end

      def call
        case @quantity_action
        when 'decrement' then decrement_line_item
        when 'increment' then increment_line_item
        end
      end

      private

      def decrement_line_item
        return false unless @current_item.quantity > 1

        @current_item.decrement!(:quantity)
        recount_price
      end

      def increment_line_item
        @current_item.increment!(:quantity)
        recount_price
      end

      def update_total_price_line_items
        @current_item.update(total_price: @current_item.item_price * @current_item.quantity)
      end

      def recount_price
        update_total_price_line_items
        Services::Orders::AmountCalculation.new(@current_order).call
      end
    end
  end
end
