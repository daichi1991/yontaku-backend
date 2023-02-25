require 'rails_helper'

RSpec.describe StudyDetail, type: :model do

  before do
    FactoryBot.create(:payment_method, key:'free')
  end
  
  describe "バリデーションチェック" do
    it "全てのカラムに値がある 有効" do
      study_detail = FactoryBot.build(:study_detail)
      expect(study_detail).to be_valid
    end

    it "studyが無い 無効" do
      study_detail = FactoryBot.build(:study_detail, study: nil)
      study_detail.valid?
      expect(study_detail.errors[:study]).to include("must exist")
    end

    it "questionが無い 無効" do
      study_detail = FactoryBot.build(:study_detail, question: nil)
      study_detail.valid?
      expect(study_detail.errors[:question]).to include("must exist")
    end

    it "skip==true answer==nil 有効" do
      study_detail = FactoryBot.build(:study_detail, skip: true, answer: nil)
      expect(study_detail).to be_valid
    end

    it "skip==true answer==値がある 無効" do
      study_detail = FactoryBot.build(:study_detail, skip: true)
      study_detail.valid?
      expect(study_detail.errors[:answer]).to include("skip==trueにも関わらずAnswerに値があります")
    end

    it "skip==false answer==nil 無効" do
      study_detail = FactoryBot.build(:study_detail, skip: false, answer: nil)
      study_detail.valid?
      expect(study_detail.errors[:answer]).to include("skip==fakseにも関わらずAnswerに値がありません")
    end

    it "skip==false answer==値がある 有効" do
      study_detail = FactoryBot.build(:study_detail, skip: false)
      expect(study_detail).to be_valid
    end

    it "skipが無い 無効" do
      study_detail = FactoryBot.build(:study_detail, skip: nil)
      study_detail.valid?
      expect(study_detail.errors[:skip]).to include("is not included in the list")
    end

    it "requied_millisecondsが無い 無効" do
      study_detail = FactoryBot.build(:study_detail, required_milliseconds: nil)
      study_detail.valid?
      expect(study_detail.errors[:required_milliseconds]).to include("can't be blank")
    end

    it "score_targetが無い 無効" do
      study_detail = FactoryBot.build(:study_detail, score_target: nil)
      study_detail.valid?
      expect(study_detail.errors[:score_target]).to include("is not included in the list")
    end
  end

  describe "set_false_score_target" do
    it "同じquestionが10より多くなった場合、一番古いレコードのscore_targetをfalseにする" do
      user = FactoryBot.create(:user)
      question = FactoryBot.create(:question)
      study = FactoryBot.create(:study, user: user)
      study_details = FactoryBot.create_list(:study_detail, 10, study: study, question: question)
      new_question = FactoryBot.create(:study_detail, question: question)
      oldest_study_detail = StudyDetail.where(study: study, question: question).order(created_at: "ASC").first
      expect(oldest_study_detail.score_target).to be false
    end
  end
end
