FactoryBot.define do
  factory :order do
    association :account
    association :sale
  end
end
