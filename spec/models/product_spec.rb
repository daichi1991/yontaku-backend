require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:user) { User.new(firebase_local_id: 'abcdef12345', active: true) }

  it "user_idとnameがある場合、有効" do
    product = Product.new(
      user: user,
      name: '商品1'
    )
    expect(product).to be_valid
  end

  it "userがない場合、無効" do
    product = Product.new(
      name: '商品1'
    )
    product.valid?
    expect(product.errors[:user]).to include("must exist")
  end

  it "nameがない場合、無効" do
    product = Product.new(
      user: user
    )
    product.valid?
    expect(product.errors[:name]).to include("can't be blank")
  end
end
