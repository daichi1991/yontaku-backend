require 'rails_helper'

RSpec.describe Rate, type: :model do
  before do
    FactoryBot.create(:payment_method, key:'free')
  end
  it "全てのカラムに値がある場合、有効" do
    rate = FactoryBot.build(:rate)
    expect(rate).to be_valid 
  end

  it "userがない場合、無効" do
    rate = FactoryBot.build(:rate, user: nil)
    rate.valid?
    expect(rate.errors[:user]).to include("must exist")
  end

  it "productがない場合、無効" do
    rate = FactoryBot.build(:rate, product: nil)
    rate.valid?
    expect(rate.errors[:product]).to include("must exist")
  end

  it "rateがない場合、無効" do
    rate = FactoryBot.build(:rate, rate: nil)
    rate.valid?
    expect(rate.errors[:rate]).to include("can't be blank")
  end

  it "rateが0の場合、無効" do
    rate = FactoryBot.build(:rate, rate: 0)
    rate.valid?
    expect(rate.errors[:rate]).to include("must be greater than or equal to 1")
  end

  it "rateが6以上の場合、無効" do
    rate = FactoryBot.build(:rate, rate: 6)
    rate.valid?
    expect(rate.errors[:rate]).to include("must be less than or equal to 5")
  end

  it "rateのuserとrate.product.userが同じ場合 無効" do
    user = FactoryBot.create(:user)
    product = FactoryBot.create(:product, user: user)
    rate = FactoryBot.build(:rate, user: user, product: product)
    rate.valid?
    expect(rate.errors[:user]).to include("自分で作った商品を評価することはできません")
  end

  it "rateのuserとrate.product.userが違う場合 無効" do
    user1 = FactoryBot.create(:user)
    product = FactoryBot.create(:product, user: user1)
    user2 = FactoryBot.create(:user)
    rate = FactoryBot.build(:rate, user: user2, product: product)
    expect(rate).to be_valid
  end
end
