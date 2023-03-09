require 'rails_helper'

RSpec.describe Tag, type: :model do
    it "nameがある場合、有効" do
    tag = FactoryBot.build(:tag)
    expect(tag).to be_valid 
  end

  it "nameがない場合、無効" do
    tag = FactoryBot.build(:tag, name: nil)
    tag.valid?
    expect(tag.errors[:name]).to include("can't be blank")
  end
end
