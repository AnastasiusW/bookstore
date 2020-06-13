FactoryBot.define do
  factory :credit_card do
    number { rand(10**12).to_s }
    card_name { FFaker::Lorem.word }
    expiration_date  { '05/25' }
    cvv { rand(10**2..10**3).to_s }
  end
end
