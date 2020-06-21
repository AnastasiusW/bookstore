FactoryBot.define do
  factory :order do
    number { 'R' + rand.to_s[2..11] }
  end
end
