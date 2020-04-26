1.times  do
    Order.create! do |order|
        order.status = 4
        order.user_id = 3
    end
end
