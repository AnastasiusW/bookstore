module Services
  module Orders
    class ChooseOrder
      NUMBER_MIN = 2
      NUMBER_MAX = 11
      def initialize(order_id, user)
        @order_id = order_id
        @current_user = user
      end

      def call
        return @current_user ? user_have_order : order_without_user
      end


      def user_have_order
        return create_or_update_order_with_user unless find_order_by_user_id
        find_order_by_user_id
      end

      def create_or_update_order_with_user
        if  find_order_by_order_id
          return  find_order_by_user_id if find_order_by_order_id.update(user_id: @current_user.id)
        else
          Order.create(user_id: @current_user.id, number: generate_number_order)
        end
      end

      def order_without_user
        return create_new_order_without_user unless find_order_by_order_id
        find_order_by_order_id
      end

      def create_new_order_without_user
        Order.create(number: generate_number_order)
      end

      def find_order_by_user_id
        @current_user.orders.where(status: :in_progress).first
      end

      def find_order_by_order_id
        Order.find_by(id: @order_id,status: :in_progress)
      end

      def generate_number_order
        'R'+ rand.to_s[NUMBER_MIN..NUMBER_MAX]
      end
    end
  end
end
