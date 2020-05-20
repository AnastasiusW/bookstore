class LineItemDecorator < Draper::Decorator
  delegate_all
  decorates_association :book

  def book_title
    book.title
  end

  def image
    book.medium_image
  end

  def price
    item_price
  end

  def sub_price
    total_price
  end

end
