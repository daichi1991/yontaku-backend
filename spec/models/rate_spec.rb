require 'rails_helper'

RSpec.describe Rate, type: :model do
  before do
    FactoryBot.create(:payment_method, key:'free')
  end

  context "バリデーション" do
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
  end

  context "validate_forbid_own_product" do
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

  context "self.amount(product)" do
    before do
      @user1 = FactoryBot.create(:user)
      @product = FactoryBot.create(:product, user: @user1)
      @user2 = FactoryBot.create(:user)
    end
    
    it "rateが0" do
      amount = Rate.amount(@product)
      expect(amount).to eq 0
    end
    
    it "rateが10" do
      FactoryBot.create_list(:rate, 10, product: @product, user: @user2)
      amount = Rate.amount(@product)
      expect(amount).to eq 10
    end
  end

  context "self.score(product)" do
    before do
      @user1 = FactoryBot.create(:user)
      @product = FactoryBot.create(:product, user: @user1)
      @user2 = FactoryBot.create(:user)
    end
    
    it "rateが0" do
      score = Rate.score(@product)
      expect(score).to eq nil
    end
    
    it "scoreが整数" do
      FactoryBot.create_list(:rate, 5, product: @product, user: @user2, rate: 5)
      score = Rate.score(@product)
      expect(score).to eq 5.0
    end

    it "scoreが小数点第一位" do
      FactoryBot.create_list(:rate, 5, product: @product, user: @user2, rate: 5)
      FactoryBot.create_list(:rate, 5, product: @product, user: @user2, rate: 4)
      score = Rate.score(@product)
      expect(score).to eq 4.5
    end
    it "scoreが小数点第二位以上" do
      FactoryBot.create(:rate, product: @product, user: @user2, rate: 2)
      FactoryBot.create(:rate, product: @product, user: @user2, rate: 3)
      FactoryBot.create(:rate, product: @product, user: @user2, rate: 5)
      score = Rate.score(@product)
      expect(score).to eq 3.3
    end
  end
end
