module Services
  module LineItems
    class Destroy

      def initialize(allowed_params:)
        @current_order = allowed_params[:order_id]
        @current_item = LineItem.find_by(id:allowed_params[:id],order_id: allowed_params[:order_id])
      end

      def call
        delete_current_line_item
      end

      def delete_current_line_item
        @current_item.destroy
        Services::Orders::AmountCalculation.new(@current_order).call
      end
    end
  end
end
