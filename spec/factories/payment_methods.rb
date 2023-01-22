FactoryBot.define do
  factory :payment_method do
    payment_method {Faker::Commerce.vendor}
  end
end
