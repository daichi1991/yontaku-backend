FactoryBot.define do
  factory :cart do
    association :user
    association :sale
  end
end
