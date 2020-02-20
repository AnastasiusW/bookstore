class SetFilterSortQuery
    DEFAULT_ORDER = 'created_at DESC'
    LATEST_BOOK_COUNT = 3

    def initialize(**params)
      @params = params
    end

    def self.call(**params)
      new(**params).call
    end

    def call
      Book
        .yield_self(&method(:latest_books))
        .yield_self(&method(:filter))
        .yield_self(&method(:sort))
    end


    def latest_books(connection)
      return connection unless @params.include?(:latest_books)

      connection.order('created_at DESC').limit(SetFilterSortQuery::LATEST_BOOK_COUNT)
    end

    def filter(connection)
        return connection unless @params[:category_id].present?

        connection.where(category_id: @params[:category_id])
    end

    def sort(connection)
        sort_order = I18n.t(:sorting).keys.include?(@params[:sort_param]&.to_sym) ? @params[:sort_param] : SetFilterSortQuery::DEFAULT_ORDER
        return popular_first(connection) if sort_order == 'popular'
        connection.order(sort_order)
    end

    def popular_first(connection)
      #Тут ставлю заглушку, так как будет запрос с inner join
      #на таблицу заказов. Она будет привязана к users,которая
      #создается в степе 3.
      connection.order("created_at DESC")
    end
end
