FactoryBot.define do
  factory :subject do
    key {Faker::Commerce.product_name()}
    name {Faker::Commerce.product_name()}
  end
end
