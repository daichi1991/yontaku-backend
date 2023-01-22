FactoryBot.define do
  factory :account do
    association :user
    association :payment_method
    active {true}
  end
end
