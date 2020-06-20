module Queries
  module Home
    class Index
      BEST_SELLERS_COUNT = 4

      def self.call
        query = %[SELECT books.* from books  where id in(SELECT DISTINCT ON (b.category_id) b.id FROM line_items as li
        INNER JOIN orders as o on li.order_id = o.id
        INNER JOIN books as b on li.book_id = b.id
        WHERE o.status in (2,3,4)
        GROUP BY b.id,b.category_id
        ORDER BY b.category_id, sum(li.quantity) DESC)]

        Book.find_by_sql(query).first(BEST_SELLERS_COUNT)
      end
    end
  end
end
