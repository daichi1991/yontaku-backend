require 'rails_helper'

RSpec.describe Cart, type: :model do
  it "user, saleがある場合、有効" do
    cart = FactoryBot.build(:cart)
    expect(cart).to be_valid
  end

  it "userがない場合、無効" do
    cart = FactoryBot.build(:cart, user: nil)
    cart.valid?
    expect(cart.errors[:user]).to include("must exist")
  end

  it "saleがない場合、無効" do
    cart = FactoryBot.build(:cart, sale: nil)
    cart.valid?
    expect(cart.errors[:sale]).to include("must exist")
  end
end
