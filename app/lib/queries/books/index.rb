module Queries
  module Books
    class Index
      def initialize(**params)
        @params = params
      end

      def call
        category_filter
      end

      def category_filter
        return Book.all unless @params[:category_id].present?

        Book.category_filter(@params[:category_id])
      end
    end
  end
end
