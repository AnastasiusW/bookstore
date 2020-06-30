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

        Category.find_by(id: @params[:category_id]).books
      end
    end
  end
end
