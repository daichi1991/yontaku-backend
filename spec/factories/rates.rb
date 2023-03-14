FactoryBot.define do
  factory :rate do
    association :user
    association :product
    rate {Faker::Number.between(from: 1, to: 5)}
  end
end
