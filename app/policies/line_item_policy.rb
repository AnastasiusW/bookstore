class LineItemPolicy < ApplicationPolicy




  def update?
    if user
      record.order.user ? record.order.user.id == user.id : record.order.id == foo.id
    else
      record.order.id == foo.id
    end
  end

  def destroy?
    if user
      record.order.user ? record.order.user.id == user.id : record.order.id == foo.id
    else
      record.order.id == foo.id
    end
  end


end
