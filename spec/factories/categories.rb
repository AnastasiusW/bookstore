FactoryBot.define do
  factory :category do
    title { FFaker::Book.unique.genre }
  end
end
