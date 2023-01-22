require 'rails_helper'

RSpec.describe Account, type: :model do
  it "user, payment_method, acriveがある場合、有効" do
    account = FactoryBot.build(:account)
    expect(account).to be_valid
  end

  it "userがない場合、無効" do
    account = FactoryBot.build(:account, user: nil)
    account.valid?
    expect(account.errors[:user]).to include("must exist")
  end

  it "payment_methodがない場合、無効" do
    account = FactoryBot.build(:account, payment_method: nil)
    account.valid?
    expect(account.errors[:payment_method]).to include("must exist")
  end

  it "activeを設定しなくてもデフォルトでtrueが入っているため、有効" do
    account = Account.new(
      user: FactoryBot.build(:user),
      payment_method: FactoryBot.build(:payment_method)
    )
    expect(account).to be_valid
    expect(account[:active]).to be true
  end

  it "activeを削除した場合、無効" do
    account = FactoryBot.build(:account, active: nil)
    account.active = nil
    account.valid?
    expect(account.errors[:active]).to include("can't be blank")
  end

end
