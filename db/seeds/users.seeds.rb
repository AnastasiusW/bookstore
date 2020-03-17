USERS_COUNT = 1

USERS_COUNT.times do
    User.create! do |user|
        user.email = FFaker::Internet.email
        user.password = FFaker::Internet.password
    end
end
