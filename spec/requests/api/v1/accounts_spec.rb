require 'rails_helper'

RSpec.describe "Api::V1::Accounts", type: :request do
  before do
    FactoryBot.create(:payment_method, key:'free')
    payment_method = FactoryBot.create(:payment_method, key:'paypal')
    user1 = FactoryBot.create(:user, uid:'abcdefg12345')
    user2 = FactoryBot.create(:user, uid:'vwxyz12345')
    FactoryBot.create(:account, payment_method: payment_method, user: user1)
  end
  let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'hoge_token' } }
  
  describe "GET /accounts/:id" do
    it "情報取得 成功" do
      payment_method = PaymentMethod.find_by(key: 'paypal')
      accounts = Account.where(payment_method: payment_method)
      user = User.find_by(uid: "abcdefg12345")
      get "/api/v1/accounts/#{accounts[0].id}.json"
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq accounts[0].id
      expect(json["user"]).to eq user.id
      expect(json["payment_method"]["id"]).to eq payment_method.id
      expect(json["payment_method"]["key"]).to eq payment_method.key
      expect(json["payment_method"]["name"]).to eq payment_method.name
    end

    it "存在しないid 失敗" do
      account_id = Account.last.id
      get "/api/v1/accounts/#{account_id + 'abc'}.json"
      expect(response.status).to eq(400)
      expect(response.body).to include("Couldn't find Account with 'id'")
    end
  end

  describe "POST /accounts" do
    it "新規作成 成功" do
      verify_id_token_default_user_stub
      payment_method = PaymentMethod.find_by(key: 'paypal')
      expect {
        post "/api/v1/accounts.json", params: 
        {
          account: {
            payment_method_id: payment_method.id,
          }
        }.to_json, headers: headers
      }.to change{Account.count}.by(1)
      expect(response.status).to eq(200)
    end

    it "payment_methodがブランク 失敗" do
      verify_id_token_default_user_stub
      expect {
        post "/api/v1/accounts.json", params: 
        {
          account: {
            active: false
          }
        }.to_json, headers: headers
      }.to change{Account.count}.by(0)
      expect(response.status).to eq(400)
      expect(response.body).to include("can't be blank")
    end
  end

  describe "GET /accounts/my_accounts" do
    it "my_accountsを取得する" do
      verify_id_token_stub
      user = User.find_by(uid: "vwxyz12345")
      payment_method = PaymentMethod.find_by(key:'free')
      get "/api/v1/accounts/my_accounts.json", headers: headers
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json[0]["user"]).to eq user.id
      expect(json[0]["payment_method"]["id"]).to eq payment_method.id
      expect(json[0]["payment_method"]["key"]).to eq payment_method.key
      expect(json[0]["payment_method"]["name"]).to eq payment_method.name
    end
  end
end
