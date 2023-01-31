require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  it "key, nameがある場合、有効" do
    payment_method = FactoryBot.build(:payment_method)
    expect(payment_method).to be_valid 
  end

  it "keyがない場合、無効" do
    payment_method = FactoryBot.build(:payment_method, key: nil)
    payment_method.valid?
    expect(payment_method.errors[:key]).to include("can't be blank")
  end

  it "nameがない場合、無効" do
    payment_method = FactoryBot.build(:payment_method, name: nil)
    payment_method.valid?
    expect(payment_method.errors[:name]).to include("can't be blank")
  end
end
