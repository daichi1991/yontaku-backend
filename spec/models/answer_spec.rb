require 'rails_helper'

RSpec.describe Answer, type: :model do
  it "question, answer, correctがある場合、有効" do
    answer = FactoryBot.build(:answer)
    expect(answer).to be_valid
  end

  it "questionがない場合、無効" do
    answer = FactoryBot.build(:answer, question: nil)
    answer.valid?
    expect(answer.errors[:question]).to include("must exist")
  end

  it "answerがない場合、無効" do
    answer = FactoryBot.build(:answer, question: nil)
    answer.valid?
    expect(answer.errors[:question]).to include("must exist")
  end

  it "同じquestionでcorrect=trueのレコードが2つ以上ある場合、無効" do
    question = FactoryBot.create(:question)
    correct_answer1 = FactoryBot.create(:correct_answer, question: question)
    correct_answer2 = FactoryBot.build(:correct_answer, question: question)
    correct_answer2.valid?
    expect(correct_answer2.errors[:correct]).to include("この問題には既に正答が存在しています")
  end

  it "同じquestionでcorrect=trueのレコードが2つ以上ある場合、有効" do
    
    binding.pry
    
    question = FactoryBot.create(:question)
    correct_answer1 = FactoryBot.create(:correct_answer, question: question)
    dummy_answer1 = FactoryBot.create(:dummy_answer, question: question)
    dummy_answer2 = FactoryBot.create(:dummy_answer, question: question)
    dummy_answer3 = FactoryBot.build(:dummy_answer, question: question)
    expect(dummy_answer3).to be_valid
  end
end
