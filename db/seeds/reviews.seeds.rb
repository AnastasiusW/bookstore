
    5.times do
        Review.create! do |review|
            review.title = FFaker::Lorem.word
            review.comment = FFaker::Lorem.paragraph
            review.status  = :approved
            review.book_id = Book.all.sample.id
            review.user_id = User.all.sample.id
            review.rating = rand(1..5)
        end
    end


