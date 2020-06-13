FactoryBot.define do
  factory :order do
    number { 'R' + rand.to_s[2..11] }
  end

  trait :with_line_items do
    after(:create) do |order|
      create_list(:line_item, 2, order: order)
    end
  end

  trait :order_addresses do
    after(:create) do |order|
      create(:address, type: BillingAddress.name, addressable_type: Order.name, addressable_id: order.id)
      create(:address, type: ShippingAddress.name, addressable_type: Order.name, addressable_id: order.id)
    end
  end
end
