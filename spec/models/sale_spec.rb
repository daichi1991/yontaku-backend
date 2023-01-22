require 'rails_helper'

RSpec.describe Sale, type: :model do
  it "product, price, publishがある場合、有効" do
    sale = FactoryBot.build(:sale)
    expect(sale).to be_valid 
  end

  it "productがない場合、無効" do
    sale = FactoryBot.build(:sale, product: nil)
    sale.valid?
    expect(sale.errors[:product]).to include("must exist")
  end

  it "priceがない場合、無効" do
    sale = FactoryBot.build(:sale, price: nil)
    sale.valid?
    expect(sale.errors[:price]).to include("can't be blank")
  end

  it "publishがない場合、無効" do
    sale = FactoryBot.build(:sale, publish: nil)
    sale.valid?
    expect(sale.errors[:publish]).to include("is not included in the list")
  end
end
