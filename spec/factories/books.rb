
DIMENSION = (1.0..10.0).freeze
MATERIALS = ['Faux leather', 'Paperback', 'Fabric binding', 'Glossy paper'].freeze

FactoryBot.define do
    factory :book do
        title { FFaker::Book.unique.title }
        description { FFaker::Book.description }
        price { rand(5.0..500.00) }
        quantity { rand(0..10) }
        width {rand(DIMENSION).floor(2) }
        height {rand(DIMENSION).floor(2)}
        depth {rand(DIMENSION).floor(2)}
        year {rand(1900..2020)}
        material {MATERIALS.sample(rand(1..3)).join(', ')}
        category
        authors { create_list(:author, 2) }
    end
end
