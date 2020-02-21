class PaginatingDecorator < Draper::CollectionDecorator
  delegate :last_page?, :next_page, :current_page
end
