module Services
  module Checkout
    class Show
      attr_reader :current_order, :presenter, :presenter_order

      def initialize(order:, params:)
        @current_order = order
        @params = params
        @presenter_order = Presenters::LineItems::Index.new(current_order)
      end

      def call(step)
        case step
        when :address then manage_address
        end
      end

      def manage_address
        @presenter = Presenters::Address.new(current_instance: @current_order)
      end
    end
  end
end
