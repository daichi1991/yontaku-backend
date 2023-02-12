require 'rails_helper'

RSpec.describe StudyDetail, type: :model do
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

    it "answerが無い 無効" do
      study_detail = FactoryBot.build(:study_detail, answer: nil)
      study_detail.valid?
      expect(study_detail.errors[:answer]).to include("must exist")
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
  end
end
