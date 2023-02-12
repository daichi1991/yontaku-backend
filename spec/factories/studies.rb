FactoryBot.define do
  factory :study do
    association :user
    association :product
    mode {Faker::Number.between(from: 0, to: 1)}
  end
end
