require 'rails_helper'

RSpec.describe User, type: :model do
  it "firebase_local_id, activeがある場合、有効" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "firebase_local_idがない場合、無効" do
    user = FactoryBot.build(:user, firebase_local_id: nil)
    user.valid?
    expect(user.errors[:firebase_local_id]).to include("can't be blank")
  end

  it "activeを設定しなくてもデフォルトでtrueが入っているため、有効" do
    user = User.new(
      firebase_local_id: 'abcdef12345'
    )
    expect(user).to be_valid
    expect(user[:active]).to be true
  end

  it "activeを削除した場合、無効" do
    user = FactoryBot.build(:user, active: nil)
    user.valid?
    expect(user.errors[:active]).to include("can't be blank")
  end

end