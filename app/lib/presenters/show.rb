module Presenters
  class Show
    DESCRIPTION_LIMIT = 250
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
  end
end
