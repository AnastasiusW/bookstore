module Services
    module Orders
      class AmountCalculation
        def initialize(order_id)
          @order_id = order_id
        end

        def call
        end


        def calculate_total_order
        end

        def calculate_subtotal_order
          binding.pry
          calculate_total_current_item.
        end

        def calculate_total_current_item
          Order.find_by(id: @order_id).line_items.map do |item|
            item.item_price * item.quantity
          end
        end
    end
  end
end
