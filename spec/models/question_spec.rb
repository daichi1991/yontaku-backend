require 'rails_helper'

RSpec.describe Question, type: :model do
  it "product, questionがある場合、有効" do
    question = FactoryBot.build(:question)
    expect(question).to be_valid
  end

  it "productがない場合、無効" do
    question = FactoryBot.build(:question, product: nil)
    question.valid?
    expect(question.errors[:product]).to include("must exist")
  end

  it "questionがない場合、無効" do
    question = FactoryBot.build(:question, question: nil)
    question.valid?
    expect(question.errors[:question]).to include("can't be blank")
  end
end
