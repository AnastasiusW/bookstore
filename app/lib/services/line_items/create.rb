module Services
  module LineItems
    class Create

      def initialize(order:, allowed_params:)
        @current_order = order
        @book_id = allowed_params[:book_id]
        @quantity = allowed_params[:quantity]
      end

      def call
        create_or_update_item
        Services::Orders::AmountCalculation.new(@current_order).call
      end

      private

      def create_or_update_item
        item_exist? ? update_item : create_line_item
      end

      def item_exist?
        @current_item = @current_order.line_items.find_by(book_id: @book_id)
      end

      def update_item
        @current_item.update(quantity: set_quantity,total_price: set_total_price)
      end

      def create_line_item
        @current_order.line_items.create(book_id:@book_id, quantity: set_quantity,item_price:set_item_price, total_price: set_total_price)
      end

      def set_item_price
        Book.find_by(id: @book_id).price
      end

      def set_quantity
        @quantity&.to_i
      end

      def set_total_price
        set_item_price * set_quantity
      end
    end
  end
end