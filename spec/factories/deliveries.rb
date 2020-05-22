FactoryBot.define do
  factory :delivery do
    from_time { rand(1.2) }
    to_time { rand(3.10) }
    price { rand(5..30) }
  end
end
