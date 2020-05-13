module Presenters
  module Books
    class Show
      DESCRIPTION_LIMIT = 250
      RATING_COUNT = 5
      attr_reader :book

      def initialize(current_book:)
        @book = current_book
      end

      def render_show_more?
        @book.description.size > DESCRIPTION_LIMIT
      end

      def description
        @book.description
      end

      def count_reviews
        @book.reviews.count
      end

      def reviews
        ReviewDecorator.decorate_collection(@book.reviews.approved.all)
      end

      def display_stars
        ReviewForm::MAX_RATING
      end
    end
  end
end
