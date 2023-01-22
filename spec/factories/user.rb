FactoryBot.define do
  factory :user do
    firebase_local_id {Faker::String.random(length: 10..50)}
    active {true}
  end
end