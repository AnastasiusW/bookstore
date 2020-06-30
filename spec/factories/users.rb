FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    confirmed_at { Time.zone.today }
  end

  trait :with_addresses do
    after(:create) do |user|
      create(:address, type: BillingAddress.name, addressable_type: User.name, addressable_id: user.id)
      create(:address, type: ShippingAddress.name, addressable_type: User.name, addressable_id: user.id)
    end
  end

  trait :with_credit_card do
    after(:create) do |user|
      create(:credit_card, user: user)
    end
  end
end
