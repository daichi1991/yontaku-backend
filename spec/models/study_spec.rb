require 'rails_helper'

RSpec.describe Study, type: :model do
  before do
    FactoryBot.create(:payment_method, key:'free')
  end
  let(:user1) { FactoryBot.create(:user, uid:'abcdefg12345') }
  let(:product) { FactoryBot.create(:product, user: user1) }
  let(:questions) { FactoryBot.create_list(:question, 10, product: product) }
  let(:user2) { FactoryBot.create(:user, uid:'qwert012345') }
  let(:study) { FactoryBot.create(:study, user: user2, product: product, mode: 0) }

  describe "バリデーションチェック" do
    it "全てのカラムに値がある 有効" do
      study = FactoryBot.build(:study)
      expect(study).to be_valid
    end

    it "userが無い 無効" do
      study = FactoryBot.build(:study, user: nil)
      study.valid?
      expect(study.errors[:user]).to include("must exist")
    end

    it "productが無い 無効" do
      study = FactoryBot.build(:study, product: nil)
      study.valid?
      expect(study.errors[:product]).to include("must exist")
    end

    it "modeがない 無効" do
      study = FactoryBot.build(:study, mode: nil)
      study.valid?
      expect(study.errors[:mode]).to include("can't be blank")
    end
  end

  describe "enum" do
    it "mode=0 有効" do
      study = FactoryBot.build(:study, mode: 0)
      study.valid?
      expect(study.mode).to eq "memory"
    end
  end

  describe "enum" do
    it "mode=1 有効" do
      study = FactoryBot.build(:study, mode: 1)
      study.valid?
      expect(study.mode).to eq "examination"
    end
  end

  describe "enum" do
    it "mode=2 有効" do
      expect {
        study = FactoryBot.build(:study, mode: 2)
      }.to raise_error(ArgumentError, include("is not a valid mode"))
    end
  end

  describe "find_result" do
    it "有効" do
      answers = []
      questions.each do |question|
        answers.push(FactoryBot.create(:answer, question: question, correct: true))
        3.times do
          answers.push(FactoryBot.create(:answer, question: question, correct: false))
        end
      end
      skips = [true, true, true, true, true, false, false, false, false, false]
      questions.each_with_index do |question, index|
        study_detail = FactoryBot.create(:study_detail,
          study: study,
          question: question,
          answer_id: skips[index] ? nil : answers[rand(index*4..index*4+3)].id,
          skip: skips[index],
          required_milliseconds: rand(1..999)
        )
      end

      result = Study.find_result(study.id)
      expect(result["study"].id).to eq study.id
      expect(result["study"].user_id).to eq user2.id
      expect(result["study"].product_id).to eq product.id
      expect(result["study"].mode).to eq "memory"
      expect(result["details"].count).to eq 10
      expect(result["details"][0]["study_detail"].id).not_to eq nil
      expect(result["details"][0]["study_detail"].study_id).not_to eq nil
      expect(result["details"][0]["study_detail"].question_id).not_to eq nil
      expect(result["details"][0]["study_detail"].answer_id).to eq nil
      expect(result["details"][0]["study_detail"].skip).to eq true
      expect(result["details"][0]["study_detail"].required_milliseconds).not_to eq nil
      expect(result["details"][0]["question"].id).not_to eq nil
      expect(result["details"][0]["question"].product_id).not_to eq nil
      expect(result["details"][0]["question"].question).not_to eq nil
      expect(result["details"][0]["answer"]).to eq nil
      expect(result["details"][0]["correct_answer"].id).not_to eq nil
      expect(result["details"][0]["correct_answer"].question_id).not_to eq nil
      expect(result["details"][0]["correct_answer"].answer).not_to eq nil
      expect(result["details"][0]["correct_answer"].correct).to eq true

      expect(result["details"][5]["study_detail"].skip).to eq false
      expect(result["details"][5]["answer"].id).not_to eq nil
      expect(result["details"][5]["answer"].question_id).not_to eq nil
      expect(result["details"][5]["answer"].answer).not_to eq nil
      expect(result["details"][5]["answer"].correct).not_to eq nil
    end
  end

  describe "memory_score" do
    it "有効" do
      answers = []
      questions.each do |question|
        answers.push(FactoryBot.create(:answer, question: question, correct: true))
        3.times do
          answers.push(FactoryBot.create(:answer, question: question, correct: false))
        end
      end
      skips = [true, true, true, true, true, false, false, false, false, false]
      4.times do
        questions.each_with_index do |question, index|
          study_detail = FactoryBot.create(:study_detail,
            study: study,
            question: question,
            answer_id: skips[index] ? nil : answers[index*4].id,
            skip: skips[index],
            required_milliseconds: rand(1..999)
          )
        end
      end
      results = study.memory_score

      expect(results[0][:question].id).not_to eq nil
      expect(results[0][:correctness]).to eq [true, true, true, true]
      expect(results[0][:score]).to eq 100

      expect(results[9][:correctness]).to eq [false, false, false, false]
      expect(results[9][:score]).to eq 0
    end
  end
end
