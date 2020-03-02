module Queries
  module Books
    class SortOrder
      DEFAULT_ORDER = :newest

      SORTING_LIST = {
        newest: I18n.t('sorting.newest_first'),
        popular: I18n.t('sorting.popular_book'),
        by_price_asc: I18n.t('sorting.price_asc'),
        by_price_desc: I18n.t('sorting.price_desc'),
        by_title_asc: I18n.t('sorting.title_asc'),
        by_title_desc: I18n.t('sorting.title_desc')
      }.freeze

      def initialize(**params)
        @params = params
      end

      def call
       sort
      end

      def sort
        sort_order = SORTING_LIST.keys.include?(@params[:sort_param]&.to_sym) ? @params[:sort_param] : DEFAULT_ORDER
        @params[:collection].public_send(sort_order)
      end
    end
  end
end
