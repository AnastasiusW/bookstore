module Services
  module Checkout
    module Delivery
      class Update
        def initialize(order:, delivery_params:)
          @current_order = order
          @delivery_params = delivery_params[:delivery_id].to_i
        end

        def call
          save_delivery_method
        end

        private

        def save_delivery_method
          ActiveRecord::Base.transaction do
            @current_order.update!(delivery_id: @delivery_params)
            Services::Orders::RecalculateAmount.new(@current_order).call
          rescue ActiveRecord::InvalidForeignKey
            raise ActiveRecord::Rollback
          end
        end
      end
    end
  end
end
