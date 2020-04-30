2.times do
  Review.create! do |review|
    review.title = FFaker::Lorem.word
    review.comment = FFaker::Lorem.paragraph
    review.status  = :approved
    review.book_id = 50
    review.user_id = 3
    review.rating = rand(1..5)
  end
end


