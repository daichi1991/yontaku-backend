require 'rails_helper'

RSpec.describe ProductTag, type: :model do
  it "product, tagがある場合、有効" do
    product_tag = FactoryBot.build(:product_tag)
    expect(product_tag).to be_valid
  end

  it "productがない場合、無効" do
    product_tag = FactoryBot.build(:product_tag, product: nil)
    product_tag.valid?
    expect(product_tag.errors[:product]).to include("must exist")
  end

  it "tagがない場合、無効" do
    product_tag = FactoryBot.build(:product_tag, tag: nil)
    product_tag.valid?
    expect(product_tag.errors[:tag]).to include("must exist")
  end
end
