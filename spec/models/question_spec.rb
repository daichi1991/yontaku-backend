require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:user) { User.new(firebase_local_id: 'abcdef12345', active: true) }
  let(:product) { Product.new(user: user, name: '商品1') }

  it "product, number, questionがある場合、有効" do
    question = Question.new(
      product: product,
      number: 1,
      question: "問題文"
    )
    expect(question).to be_valid
  end

  it "productがない場合、無効" do
    question = Question.new(
      number: 1,
      question: "問題文"
    )
    question.valid?
    expect(question.errors[:product]).to include("must exist")
  end

  it "numberがない場合、無効" do
    question = Question.new(
      product: product,
      question: "問題文"
    )
    question.valid?
    expect(question.errors[:number]).to include("can't be blank")
  end

  it "questionがない場合、無効" do
    question = Question.new(
      product: product,
      number: 1
    )
    question.valid?
    expect(question.errors[:question]).to include("can't be blank")
  end
end
