require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:user) { User.new(firebase_local_id: 'abcdef12345', active: true) }
  let(:product) { Product.new(user: user, name: '商品1')}
  let(:sale) { Sale.new(product: product, price: 100, publish: true) }

  it "user, saleがある場合、有効" do
    cart = Cart.new(
      user: user,
      sale: sale
    )
    expect(cart).to be_valid
  end

  it "userがない場合、無効" do
    cart = Cart.new(
      sale: sale
    )
    cart.valid?
    expect(cart.errors[:user]).to include("must exist")
  end

  it "saleがない場合、無効" do
    cart = Cart.new(
      user: user
    )
    cart.valid?
    expect(cart.errors[:sale]).to include("must exist")
  end
end
