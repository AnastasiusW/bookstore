FactoryBot.define do
  factory :order do


  end
=begin
  trait :with_line_items do
    after(:create) do |item|
      create(:line_item,quantity:2)
    end
  end
   user { create(:user) }
=end

end
