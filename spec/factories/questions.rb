FactoryBot.define do
  factory :question do
    association :product
    sequence(:number){|n| n}
    question {Faker::Quote.yoda}
  end
end
