FactoryBot.define do
  factory :product do
    association :user
    association :subject
    name {Faker::Commerce.product_name()}
    description {Faker::Quote.yoda}
  end
end
