FactoryBot.define do
  factory :subject do
    key {Faker::Commerce.product_name()}
    name {Faker::Commerce.product_name()}
    image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/images/test.jpg'), 'image/jpg')}
  end
end
