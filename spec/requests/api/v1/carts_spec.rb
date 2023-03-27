require 'rails_helper'

RSpec.describe "Api::V1::Carts", type: :request do
  before do
    @user = FactoryBot.create(:user, uid:'vwxyz12345', active: true)
    @user2 = FactoryBot.create(:user, uid:'abcdefg12345', active: true)
    @product = FactoryBot.create(:product, user: @user)
    @product2 = FactoryBot.create(:product, user: @user)
    @sale = FactoryBot.create(:sale, product: @product, publish: true)
    @sale2 = FactoryBot.create(:sale, product: @product2, publish: true)
  end
  let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'hoge_token' } }
  
  describe "POST /carts" do
    it "新規作成 成功" do
      verify_id_token_default_user_stub
      expect {
        post "/api/v1/carts.json", params:
        {
          cart: {
            sale_id: @sale.id
          }
        }.to_json, headers: headers
      }.to change{Cart.count}.by(1)
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json[0]["sale"]["id"]).to eq @sale.id
    end

    it "パラメータ不足 成功" do
      verify_id_token_default_user_stub
      expect {
        post "/api/v1/carts.json", params:
        {
          cart: {
            sale_id: nil
          }
        }.to_json, headers: headers
      }.to change{Cart.count}.by(0)
      expect(response.status).to eq(400)
    end
  end

  describe "GET /carts/current_user_cart" do
    it "成功" do
      verify_id_token_default_user_stub
      Cart.create(sale: @sale, user: @user2)
      Cart.create(sale: @sale2, user: @user2)
      get "/api/v1/carts/current_user_cart.json"
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json[0]["sale"]["id"]).to eq @sale.id
      expect(json[1]["sale"]["id"]).to eq @sale2.id
    end

    it "データなし 成功" do
      verify_id_token_default_user_stub
      get "/api/v1/carts/current_user_cart.json"
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json).to eq []
    end
  end
end
