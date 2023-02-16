FactoryBot.define do
  factory :study_detail do
    association :study
    association :question
    association :answer
    skip {false}
    required_milliseconds {Faker::Number.number(digits: 5)}
  end
end
