require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  before do
    FactoryBot.create(:payment_method, key:'free')
    FactoryBot.create(:user, uid:'abcdefg12345')
  end
  let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'hoge_token' } }

  describe "GET /users/:id" do
    it "特定のuser情報を取得する" do
      authenticate_stub
      user_id = User.last.id
      get "/api/v1/users/#{user_id}.json", headers: headers
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq user_id
    end

    it "存在しないidでuser情報にアクセスして失敗" do
      authenticate_stub
      user_id = User.last.id
      get "/api/v1/users/#{user_id + 'abc'}.json", headers: headers
      expect(response.status).to eq(400)
      expect(response.body).to include("Couldn't find User with 'id'")
    end
  end

  describe "POST /users" do
    it "userを新規作成する" do
      verify_id_token_stub
      expect {
        post "/api/v1/users.json", headers: headers
      }.to change{User.count}.by(1)
      expect(response.status).to eq(200)
    end

    it "不正なtokenで新規作成を失敗する" do
      verify_id_token_blank_stub
      expect {
        post "/api/v1/users.json", headers: headers
      }.to raise_error(ArgumentError, "BadRequest Parameter")
    end

    it "既に存在しているユーザー新規作成で失敗する" do
      verify_id_token_default_user_stub
      expect {
        post "/api/v1/users.json", headers: headers
      }.to raise_error(ArgumentError, "既に存在しているユーザーです")
    end
  end

  describe "PUT /users" do
    it "usernameを上書きする" do
      verify_id_token_default_user_stub
      user_id = User.find_by(uid: "abcdefg12345").id
      expect {
        put "/api/v1/users/#{user_id}.json", params: 
        {
          user: {
            username: "テストユーザー"
          }
        }.to_json, headers: headers
      }.to change{User.count}.by(0)
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["username"]).to eq "テストユーザー"
    end

    it "usernameを不正な値で上書きする" do
      verify_id_token_default_user_stub
      user_id = User.find_by(uid: "abcdefg12345").id
      username = 'a' * 101
      expect {
        put "/api/v1/users/#{user_id}.json", params: 
        {
          user: {
            username: username
          }
        }.to_json, headers: headers
      }.to change{User.count}.by(0)
      expect(response.status).to eq(400)
      json = JSON.parse(response.body)      
      expect(json["username"]).to eq ["is too long (maximum is 100 characters)"]
    end
  end

  describe "GET /users/current_user_infrmation" do
    it "自分の情報を取得する" do
      verify_id_token_default_user_stub
      current_user = User.find_by(uid: "abcdefg12345")
      get "/api/v1/users/current_user_infrmation.json", headers: headers
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq current_user.id
    end
  end
end
