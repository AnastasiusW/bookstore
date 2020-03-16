AUTHORS_COUNT=5

AUTHORS_COUNT.times do
    Author.create! do |author|
        author.firstname = FFaker::Name.unique.first_name
        author.lastname = FFaker::Name.unique.last_name
        author.biography = FFaker::Lorem.paragraph
    end
end
