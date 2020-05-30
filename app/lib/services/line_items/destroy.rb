module Services
  module LineItems
    class Destroy
      def initialize(allowed_params:)
        @current_order = allowed_params[:order_id]
        @current_item = LineItem.find_by(id: allowed_params[:id], order_id: allowed_params[:order_id])
      end

      def call
        delete_current_line_item
      end

      def delete_current_line_item
        return false unless @current_item

        ActiveRecord::Base.transaction do
          @current_item.destroy
          Services::Orders::RecalculateAmount.new(@current_order).call
        end
      rescue ActiveRecord::RecordInvalid
        flash[:alert] = I18n.t('transaction.fail.destroy_line_item')
      end
    end
  end
end
