FactoryBot.define do
  factory :user do
    uid {Faker::Alphanumeric.alphanumeric(number: 30)}
    active {Faker::Boolean.boolean(true_ratio: 0.5)}
  end
end