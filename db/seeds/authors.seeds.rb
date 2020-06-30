AUTHORS_COUNT=5

AUTHORS_COUNT.times do
    Author.create! do |author|
        author.first_name = FFaker::Name.unique.first_name
        author.last_name = FFaker::Name.unique.last_name
        author.biography = FFaker::Lorem.paragraph
    end
end
