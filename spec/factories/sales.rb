FactoryBot.define do
  factory :sale do
    association :product
    price {Faker::Commerce.price(range: 0..100000.00)}
    publish {true}
  end
end
