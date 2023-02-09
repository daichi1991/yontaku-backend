FactoryBot.define do
  factory :question do
    association :product
    question {Faker::Quote.yoda}
  end
end
