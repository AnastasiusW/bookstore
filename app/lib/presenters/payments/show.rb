module Presenters
  module Payments
    class Show
      def initialize(current_order:)
        @current_order = current_order
      end

      def check_credit_card
        @current_order.user.credit_card || CreditCardForm.new
      end

      def take_user_id
        @current_order.user.id
      end
    end
  end
end
