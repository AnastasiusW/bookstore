module Presenters
  module Orders
    class Index
      def initialize(orders:, sort_order:)
        @orders = orders
        @sort_order = sort_order
      end

      def orders
        OrderDecorator.decorate_collection(@orders)
      end

      def selected_order
        Queries::Orders::Index::ALLOWED_STATUS[prepare_sort_order]
      end

      def orders_sorting_list
        Queries::Orders::Index::ALLOWED_STATUS
      end

      private

      def prepare_sort_order
        (@sort_order || Queries::Orders::Index::DEFAULT_SORT_PARAM).to_sym
      end
    end
  end
end
