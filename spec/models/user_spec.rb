require 'rails_helper'

RSpec.describe User, type: :model do
  it "uid, activeがある場合、有効" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "uidがない場合、無効" do
    user = FactoryBot.build(:user, uid: nil)
    user.valid?
    expect(user.errors[:uid]).to include("can't be blank")
  end

  it "activeを設定しなくてもデフォルトでtrueが入っているため、有効" do
    user = User.new(
      uid: 'abcdef12345'
    )
    expect(user).to be_valid
    expect(user[:active]).to be true
  end

  it "activeを削除した場合、無効" do
    user = FactoryBot.build(:user, active: nil)
    user.valid?
    expect(user.errors[:active]).to include("is not included in the list")
  end

  it "uidが重複した場合、無効" do
    user1 = FactoryBot.create(:user, uid: 'abcdef12345')
    user2 = FactoryBot.build(:user, uid: 'abcdef12345')
    user2.valid?
    expect(user2.errors[:uid]).to include("has already been taken")
  end

end