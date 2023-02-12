require 'rails_helper'

RSpec.describe "Api::V1::Studies", type: :request do
  before do
    FactoryBot.create(:payment_method, key:'free')
    user = FactoryBot.create(:user, uid:'abcdefg12345')
    product = FactoryBot.create(:product, user: user)
    FactoryBot.create(:study, product: product)
  end
  let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'hoge_token' } }

  describe "GET /studies/:id" do
    it "情報取得 成功" do
      studys_id = Study.last.id
      get "/api/v1/studies/#{studys_id}.json"
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq studys_id
    end

    it "存在しないID 失敗" do
      studys_id = Study.last.id
      get "/api/v1/studies/#{studys_id + 'abc'}.json"
      expect(response.status).to eq(400)
      expect(response.body).to include("Couldn't find Study with 'id'")
    end
  end

  describe "POST /studies" do
    it "新規作成 成功" do
      verify_id_token_default_user_stub
      product_id = Product.last.id
      expect {
        post "/api/v1/studies.json", params: 
        {
          study: {
            product_id: product_id,
            mode: 0
          }
        }.to_json, headers: headers
      }.to change{Study.count}.by(1)
      expect(response.status).to eq(200)
    end

    it "パラメータ不足 失敗" do
      verify_id_token_default_user_stub
      product_id = Product.last.id
      expect {
        post "/api/v1/studies.json", params: 
        {
          study: {
            product_id: product_id
          }
        }.to_json, headers: headers
      }.to change{Study.count}.by(0)
      expect(response.status).to eq(400)
    end
  end
end
