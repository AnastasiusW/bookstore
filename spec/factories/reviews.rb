FactoryBot.define do
    factory :review do
      title { FFaker::Lorem.word }
      comment { FFaker::Lorem.paragraph }
      rating { rand(1..5) }
    end
  end
