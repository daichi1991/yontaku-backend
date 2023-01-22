require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  it "payment_methodがある場合、有効" do
    payment_method = FactoryBot.build(:payment_method)
    expect(payment_method).to be_valid 
  end

  it "payment_methodがない場合、無効" do
    payment_method = FactoryBot.build(:payment_method, payment_method: nil)
    payment_method.valid?
    expect(payment_method.errors[:payment_method]).to include("can't be blank")
  end
end
