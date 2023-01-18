require 'rails_helper'

RSpec.describe User, type: :model do
  it "irebase_local_id, activeがある場合、有効" do
    user = User.new(
      firebase_local_id: 'abcdef12345',
      active: true
    )
    expect(user).to be_valid
  end

  it "firebase_local_idがない場合、無効" do
    user = User.new(
      active: true
    )
    user.valid?
    expect(user.errors[:firebase_local_id]).to include("can't be blank")
  end

  it "activeがない場合、無効" do
    user = User.new(
      firebase_local_id: 'abcdef12345'
    )
    user.valid?
    expect(user.errors[:active]).to include("can't be blank")
  end

end