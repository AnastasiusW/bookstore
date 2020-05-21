class LineItemDecorator < Draper::Decorator
  delegate_all
  decorates_association :book

  def image
    book.medium_image
  end

end
