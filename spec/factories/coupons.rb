FactoryBot.define do
  factory :coupon do
    code { FFaker::Lorem.word }
    discount_amount { rand(1..99) }
  end
end
