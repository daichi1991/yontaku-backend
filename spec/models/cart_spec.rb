require 'rails_helper'

RSpec.describe Cart, type: :model do
  before do
    FactoryBot.create(:payment_method, key:'free')
  end
  describe "バリデーションチェック" do
    it "user, saleがある場合 有効" do
      cart = FactoryBot.build(:cart)
      expect(cart).to be_valid
    end

    it "userがない場合 無効" do
      cart = FactoryBot.build(:cart, user: nil)
      cart.valid?
      expect(cart.errors[:user]).to include("must exist")
    end

    it "saleがない場合 無効" do
      cart = FactoryBot.build(:cart, sale: nil)
      cart.valid?
      expect(cart.errors[:sale]).to include("must exist")
    end

    it "saleのuserとcart.product.userが同じ場合 無効" do
      user = FactoryBot.create(:user)
      product = FactoryBot.create(:product, user: user)
      sale = FactoryBot.create(:sale, product: product)
      cart = FactoryBot.build(:cart, user: user, sale: sale)
      cart.valid?
      expect(cart.errors[:user]).to include("自分で作った商品をカートに入れることはできません")
    end

      it "saleのuserとcart.product.userが違う場合 有効" do
      user1 = FactoryBot.create(:user)
      product = FactoryBot.create(:product, user: user1)
      sale = FactoryBot.create(:sale, product: product)
      user2 = FactoryBot.create(:user)
      cart = FactoryBot.build(:cart, user: user2, sale: sale)
      expect(cart).to be_valid
    end

  end
end
