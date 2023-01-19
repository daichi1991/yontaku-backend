require 'rails_helper'

RSpec.describe Sale, type: :model do
  let(:user) { User.new(firebase_local_id: 'abcdef12345', active: true) }
  let(:product) {Product.new(user: user, name: '商品1')}
  it "product, price, publishがある場合、有効" do
    sale = Sale.new(
      product: product,
      price: 100,
      publish: true
    )
    expect(sale).to be_valid 
  end

  it "productがない場合、無効" do
    sale = Sale.new(
      price: 100,
      publish: true
    )
    sale.valid?
    expect(sale.errors[:product]).to include("must exist")
  end

  it "priceがない場合、無効" do
    sale = Sale.new(
      product: product,
      publish: true
    )
    sale.valid?
    expect(sale.errors[:price]).to include("can't be blank")
  end

    it "publishがない場合、無効" do
    sale = Sale.new(
      product: product,
      price: 100
    )
    sale.valid?
    expect(sale.errors[:publish]).to include("can't be blank")
  end
end
