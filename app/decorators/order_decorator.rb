class OrderDecorator < Draper::Decorator
  delegate_all

  def date_order
    order.created_at.to_formatted_s(:long)
  end
end
