FactoryBot.define do
  factory :line_item do
    quantity { 1 }
    book
    order
  end
end
