FactoryBot.define do
  factory :address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::Address.street_address }
    city { FFaker::Address.city }
    country { ISO3166::Country.codes.sample }
    zip { FFaker::AddressUA.zip_code.to_i }
    phone { '+380' + rand(10**11).to_s }
  end
end
