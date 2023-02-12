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

    it "modeがない場合、無効" do
      study = FactoryBot.build(:study, mode: nil)
      study.valid?
      expect(study.errors[:mode]).to include("can't be blank")
    end
  end
end
