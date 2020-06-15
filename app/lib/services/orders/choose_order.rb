module Services
  module Orders
    class ChooseOrder
      NUMBER_MIN = 2
      NUMBER_MAX = 11

      def initialize(order_id, user)
        @order_id = order_id
        @current_user = user
        @current_order_with_user = @current_user.orders.where(status: :in_progress).first if @current_user
        @current_order_without_user = Order.find_by(id: @order_id, status: :in_progress) if @order_id
      end

      def call
        return @current_order_with_user if @current_order_with_user

        @current_user ? create_or_update_order_with_user : order_without_user
      end

      private

      def create_or_update_order_with_user
        if @current_order_without_user
          return @current_order_without_user if @current_order_without_user.update(user_id: @current_user.id)
        else
          Order.create!(user_id: @current_user.id, number: generate_order_number)
        end
      end

      def order_without_user
        return @current_order_without_user if @current_order_without_user

        create_new_order_without_user
      end

      def create_new_order_without_user
        Order.create!(number: generate_order_number)
      end

      def generate_order_number
        number = generate_number
        number = generate_number while Order.find_by(number: number)
        number
      end

      def generate_number
        'R' + rand.to_s[NUMBER_MIN..NUMBER_MAX]
      end
    end
  end
end
