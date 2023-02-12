FactoryBot.define do
  factory :study do
    association :user
    association :product
    mode {Faker::Number.number(digits: 2)}
  end
end
