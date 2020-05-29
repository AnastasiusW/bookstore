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
       # @current_user ? user_have_order : order_without_user
       return  @current_order_with_user if  @current_order_with_user
       @current_user ? create_or_update_order_with_user : order_without_user

      end

      private
=begin
      def user_have_order
        return create_or_update_order_with_user unless  @current_order_with_user

        @current_order_with_user
      end
=end
      def create_or_update_order_with_user
        if @current_order_without_user
          return  @current_order_without_user if @current_order_without_user.update(user_id: @current_user.id)
        else
          Order.create(user_id: @current_user.id, number: generate_number_order)
        end
      end

      def order_without_user
        return  @current_order_without_user if  @current_order_without_user
       create_new_order_without_user
      end

      def create_new_order_without_user
        number = generate_number_order
        return create_new_order_without_user if Order.find_by(number: number)
        Order.create(number: number)
      end
=begin
      def find_order_by_user_id
        @current_user.orders.where(status: :in_progress).first
      end

      def fetch_order
        return false unless @order_id

        Order.find_by(id: @order_id, status: :in_progress)
      end
=end
      def generate_number_order
        'R' + rand.to_s[NUMBER_MIN..NUMBER_MAX]
      end
    end
  end
end
