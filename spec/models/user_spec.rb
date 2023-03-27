require 'rails_helper'

RSpec.describe User, type: :model do
  context 'バリデーションチェック' do
    it "uid, activeがある場合、有効" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it "uidがない場合、無効" do
      user = FactoryBot.build(:user, uid: nil)
      user.valid?
      expect(user.errors[:uid]).to include("can't be blank")
    end

    it "activeを設定しなくてもデフォルトでtrueが入っているため、有効" do
      user = User.new(
        uid: 'abcdef12345'
      )
      expect(user).to be_valid
      expect(user[:active]).to be true
    end

    it "activeを削除した場合、無効" do
      user = FactoryBot.build(:user, active: nil)
      user.valid?
      expect(user.errors[:active]).to include("is not included in the list")
    end

    it "uidが重複した場合、無効" do
      user1 = FactoryBot.create(:user, uid: 'abcdef12345')
      user2 = FactoryBot.build(:user, uid: 'abcdef12345')
      user2.valid?
      expect(user2.errors[:uid]).to include("has already been taken")
    end

    context "username" do
      it "文字数1 OK" do
        user = FactoryBot.create(:user, uid: 'abcdef12345')
        user.update(username: 'a')
        expect(user).to be_valid
        expect(user[:username]).to eq 'a'
      end

      it "文字数100 OK" do
        user = FactoryBot.create(:user, uid: 'abcdef12345')
        username = 'a' * 100
        user.update(username: username)
        expect(user).to be_valid
        expect(user[:username]).to eq 'a' * 100
      end

      it "文字数101 NG" do
        user = FactoryBot.create(:user, uid: 'abcdef12345')
        username = 'a' * 101
        user.update(username: username)
        user.valid?
        expect(user.errors[:username]).to include("is too long (maximum is 100 characters)")
      end
    end
  end
  context 'Accountモデルのチェック' do
    it 'Userが新規作成されたらAccountも新規作成されること' do
      payment_method = PaymentMethod.find_by(key: 'free')
      expect{
        user = FactoryBot.create(:user)
      }.to change {Account.first}.from(nil).to(have_attributes(payment_method: payment_method))
    end
  end

end