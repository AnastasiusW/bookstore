module Queries
  module Orders
    class Index
      DEFAULT_SORT_PARAM = :in_queue

      ALLOWED_STATUS = {
        in_queue: I18n.t('order_block.sorting.in_queue'),
        in_delivery: I18n.t('order_block.sorting.in_delivery'),
        delivered: I18n.t('order_block.sorting.delivered'),
        canceled: I18n.t('order_block.sorting.canceled')
      }.freeze

      def initialize(sort_param:, user:)
        @sort_param = sort_param&.to_sym
        @current_user = user
      end

      def call
        @current_user.orders.where(status: check_sort).order(created_at: :desc)
      end

      private

      def check_sort
        ALLOWED_STATUS.keys.include?(@sort_param) ? @sort_param : DEFAULT_SORT_PARAM
      end
    end
  end
end
