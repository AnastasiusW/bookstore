2.times  do
    Order.create! do |order|
        order.status = 2
        order.user_id = User.all.sample.id
    end
end
