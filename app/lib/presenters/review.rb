module Presenters
    class Review
      RATING_COUNT = 5
      def initialize(current_book:)
        @book = current_book

      end

      def count_review
        @book.reviews.count
      end

      def reviews
        ReviewDecorator.decorate_collection(@book.reviews.all)
      end

      def display_stars
       ReviewForm::MAX_RATING
      end

    end
  end
