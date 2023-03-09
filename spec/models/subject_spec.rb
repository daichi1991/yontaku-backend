require 'rails_helper'

RSpec.describe Subject, type: :model do
  it "key, nameがある場合、有効" do
    subject = FactoryBot.build(:subject)
    expect(subject).to be_valid 
  end

  it "keyがない場合、無効" do
    subject = FactoryBot.build(:subject, key: nil)
    subject.valid?
    expect(subject.errors[:key]).to include("can't be blank")
  end

  it "nameがない場合、無効" do
    subject = FactoryBot.build(:subject, name: nil)
    subject.valid?
    expect(subject.errors[:name]).to include("can't be blank")
  end
end
