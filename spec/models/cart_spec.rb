require 'rails_helper'

RSpec.describe Cart, type: :model do
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

    it "saleのuserとsale.product.userが同じ場合 無効" do
      user = FactoryBot.create(:user)
      product = FactoryBot.create(:product, user: user)
      sale = FactoryBot.create(:sale, product: product)
      cart = FactoryBot.build(:cart, user: user, sale: sale)
      cart.valid?
      expect(cart.errors[:user]).to include("自分で作った商品をカートに入れることはできません")
    end

    it "saleのuserとsale.product.userが違う場合 有効" do
      user1 = FactoryBot.create(:user)
      product = FactoryBot.create(:product, user: user1)
      sale = FactoryBot.create(:sale, product: product)
      user2 = FactoryBot.create(:user)
      cart = FactoryBot.build(:cart, user: user2, sale: sale)
      expect(cart).to be_valid
    end

    it "既にcartに入っているsale 無効" do
      user1 = FactoryBot.create(:user)
      product = FactoryBot.create(:product, user: user1)
      sale = FactoryBot.create(:sale, product: product)
      user2 = FactoryBot.create(:user)
      FactoryBot.create(:cart, user: user2, sale: sale)
      cart = FactoryBot.build(:cart, user: user2, sale: sale)
      cart.valid?
      expect(cart.errors[:base]).to include("既にカートに入っています")
    end

    it "既にcartに入っているのとは違うsaleを入れる 有効" do
      user1 = FactoryBot.create(:user)
      product1 = FactoryBot.create(:product, user: user1)
      product2 = FactoryBot.create(:product, user: user1)
      sale1 = FactoryBot.create(:sale, product: product1)
      sale2 = FactoryBot.create(:sale, product: product2)
      user2 = FactoryBot.create(:user)
      FactoryBot.create(:cart, user: user2, sale: sale1)
      cart = FactoryBot.build(:cart, user: user2, sale: sale2)
      expect(cart).to be_valid
    end

    it "cartに入っているsaleと同じproductのsale 無効" do
      user1 = FactoryBot.create(:user)
      product = FactoryBot.create(:product, user: user1)
      sale1 = FactoryBot.create(:sale, product: product)
      sale2 = FactoryBot.create(:sale, product: product)
      user2 = FactoryBot.create(:user)
      FactoryBot.create(:cart, user: user2, sale: sale1)
      cart = FactoryBot.build(:cart, user: user2, sale: sale2)
      cart.valid?
      expect(cart.errors[:base]).to include("同じ商品をカートに入れることはできません")
    end

  end
end
