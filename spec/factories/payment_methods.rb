FactoryBot.define do
  factory :payment_method do
    key {Faker::Commerce.product_name()}
    name {Faker::Commerce.product_name()}
  end

  factory :default_payment_method do
    key {'free'}
    name {'フリー'}
  end
end
