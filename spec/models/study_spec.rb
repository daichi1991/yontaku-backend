require 'rails_helper'

RSpec.describe Study, type: :model do
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
end
