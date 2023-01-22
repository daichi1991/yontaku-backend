require 'rails_helper'

RSpec.describe Order, type: :model do
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
end
