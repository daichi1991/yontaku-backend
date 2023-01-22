FactoryBot.define do
  factory :answer do
    association :question
    answer {Faker::Book.title}
    correct {Faker::Boolean.boolean(true_ratio: 0.2)}
  end

  factory :correct_answer, class: Answer do
    answer {Faker::Book.title}
    correct {true}
  end

  factory :dummy_answer, class: Answer do
    answer {Faker::Book.title}
    correct {false}
  end
end
