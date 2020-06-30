class LineItemPolicy < ApplicationPolicy
  def update?
    check_item
  end

  def destroy?
    check_item
  end

  private

  def check_item
    if user
      record.order.user ? record.order.user.id == user.id : record.order.id == foo.id
    else
      record.order.id == foo.id
    end
  end
end
