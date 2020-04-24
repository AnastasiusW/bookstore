FactoryBot.define do
  factory :order do
    user { create(:user) }
  end
end
