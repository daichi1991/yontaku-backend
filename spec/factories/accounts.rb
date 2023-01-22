FactoryBot.define do
  factory :account do
    association :user
    association :payment_method
    active {Faker::Boolean.boolean(true_ratio: 0.5)}
  end
end
