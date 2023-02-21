require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    FactoryBot.create(:payment_method, key:'free')
  end
  describe "バリデーションチェック" do
    it "account, saleがある場合、有効" do
      order = FactoryBot.build(:order)
      expect(order).to be_valid
    end

    it "accountがない場合、無効" do
      order = FactoryBot.build(:order, account: nil)
      order.valid?
      expect(order.errors[:account]).to include("must exist")
    end

    it "saleがない場合、無効" do
      order = FactoryBot.build(:order, sale: nil)
      order.valid?
      expect(order.errors[:sale]).to include("must exist")
    end

    it "order.account.userとsale.product.userが同じ場合 無効" do
      user = FactoryBot.create(:user)
      account = FactoryBot.create(:account, user: user)
      product = FactoryBot.create(:product, user: user)
      sale = FactoryBot.create(:sale, product: product)
      order = FactoryBot.build(:order, account: account, sale: sale)
      order.valid?
      expect(order.errors[:user]).to include("自分で作った商品を購入することはできません")
    end

    it "order.account.userとsale.product.userが違う場合 有効" do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:user)
        account = FactoryBot.create(:account, user: user1)
        product = FactoryBot.create(:product, user: user2)
        sale = FactoryBot.create(:sale, product: product)
        order = FactoryBot.build(:order, account: account, sale: sale)
        expect(order).to be_valid
    end

    it "saleがpublish==falseの場合 無効" do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:user)
        account = FactoryBot.create(:account, user: user1)
        product = FactoryBot.create(:product, user: user2)
        sale = FactoryBot.create(:sale, product: product, publish: false)
        order = FactoryBot.build(:order, account: account, sale: sale)
        order.valid?
        expect(order.errors[:sale]).to include("販売情報が現在未公開のため購入することができません")
    end

    it "saleがpublish==trueの場合 無効" do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:user)
        account = FactoryBot.create(:account, user: user1)
        product = FactoryBot.create(:product, user: user2)
        sale = FactoryBot.create(:sale, product: product, publish: true)
        order = FactoryBot.build(:order, account: account, sale: sale)
        expect(order).to be_valid
    end

    it "saleが最新でない場合 無効" do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:user)
        account = FactoryBot.create(:account, user: user1)
        product = FactoryBot.create(:product, user: user2)
        sale1 = FactoryBot.create(:sale, product: product, publish: true)
        sale2 = FactoryBot.create(:sale, product: product, publish: true)
        order = FactoryBot.build(:order, account: account, sale: sale1)
        order.valid?
        expect(order.errors[:sale]).to include("最新の販売情報でないため購入することができません")
    end

    it "saleがの場合 有効" do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:user)
        account = FactoryBot.create(:account, user: user1)
        product = FactoryBot.create(:product, user: user2)
        sale1 = FactoryBot.create(:sale, product: product, publish: true)
        sale2 = FactoryBot.create(:sale, product: product, publish: true)
        order = FactoryBot.build(:order, account: account, sale: sale2)
        expect(order).to be_valid
    end
  end

end
