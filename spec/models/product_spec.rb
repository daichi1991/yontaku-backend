require 'rails_helper'

RSpec.describe Product, type: :model do
  it "user_idとnameがある場合 有効" do
    product = FactoryBot.build(:product)
    expect(product).to be_valid
  end

  it "userがない場合 無効" do
    product = FactoryBot.build(:product, user: nil)
    product.valid?
    expect(product.errors[:user]).to include("must exist")
  end

  it "nameがない場合 無効" do
    product = FactoryBot.build(:product, name: nil)
    product.valid?
    expect(product.errors[:name]).to include("can't be blank")
  end

  it "usernameがないユーザー 無効" do
    user = FactoryBot.create(:user, username: nil)
    product = FactoryBot.build(:product, user: user)
    product.valid?
    expect(product.errors[:user]).to include("ユーザー名の入力が必要です")
  end
end
