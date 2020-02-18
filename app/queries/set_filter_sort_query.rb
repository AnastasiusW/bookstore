class SetFilterSortQuery
    DEFAULT_ORDER = 'created_at DESC'

    def initialize(**params)
      @params = params
    end

    def self.call(**params)
      new(**params).call
    end

    def call
      Book
        .yield_self(&method(:filter))
        .yield_self(&method(:sort))
    end



    def filter(connection)
        return connection unless @params[:category_id].present?

        connection.where(category_id: @params[:category_id])
    end

    def sort(connection)
        sort_order = I18n.t(:sorting).keys.include?(@params[:sort_param]&.to_sym) ? @params[:sort_param] : DEFAULT_ORDER

        connection.order(sort_order)
    end
end
