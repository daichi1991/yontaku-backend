require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:user) { User.new(firebase_local_id: 'abcdef12345', active: true) }
  let(:payment_method) { PaymentMethod.new(payment_method: 'method1') }

  it "user, payment_method, acriveがある場合、有効" do
    account = Account.new(
      user: user,
      payment_method: payment_method,
      active: true
    )
    expect(account).to be_valid
  end

  it "userがない場合、無効" do
    account = Account.new(
      payment_method: payment_method,
      active: true
    )
    account.valid?
    expect(account.errors[:user]).to include("must exist")
  end

  it "payment_methodがない場合、無効" do
    account = Account.new(
      user: user,
      active: true
    )
    account.valid?
    expect(account.errors[:payment_method]).to include("must exist")
  end

  it "activeを設定しなくてもデフォルトでtrueが入っているため、有効" do
    account = Account.new(
      user: user,
      payment_method: payment_method
    )
    expect(account).to be_valid
    expect(account[:active]).to be true
  end

  it "activeを削除した場合、無効" do
    account = Account.new(
      user: user,
      payment_method: payment_method
    )
    account.active = nil
    account.valid?
    expect(account.errors[:active]).to include("can't be blank")
  end

end
