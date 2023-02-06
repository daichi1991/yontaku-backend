require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  before do
    FactoryBot.create(:payment_method, key:'free')
    FactoryBot.create(:user, uid:'abcdefg12345')
  end
  let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'hoge_token' } }

  describe "GET /users/:id" do
    it "特定のユーザー情報を取得する" do
      authenticate_stub
      user_id = User.last.id
      get "/api/v1/users/#{user_id}.json", headers: headers
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq user_id
      expect(json["active"]).to be true
    end

    it "存在しないidでユーザー情報にアクセスして失敗" do
      authenticate_stub
      user_id = User.last.id
      get "/api/v1/users/#{user_id+1}.json", headers: headers
      expect(response.status).to eq(400)
      expect(response.body).to include("Couldn't find User with 'id'")
    end
  end

  describe "POST /users" do
    it "ユーザーを新規作成する" do
      verify_id_token_stub
      expect {
        post "/api/v1/users.json", headers: headers
      }.to change{User.count}.by(1)
      expect(response.status).to eq(200)
    end
  end
end
