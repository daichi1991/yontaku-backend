require 'rails_helper'

RSpec.describe "Api::V1::Sales", type: :request do
  before do
    user = FactoryBot.create(:user, uid:'abcdefg12345')
    product = FactoryBot.create(:product, user: user)
    FactoryBot.create(:sale, product: product)
  end
  let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'hoge_token' } }

  describe "GET /sales/:id" do
    it "情報取得 成功" do
      sales_id = Sale.last.id
      get "/api/v1/sales/#{sales_id}.json"
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq sales_id
    end

    it "存在しないID 失敗" do
      sales_id = Sale.last.id
      get "/api/v1/sales/#{sales_id + 'abc'}.json"
      expect(response.status).to eq(400)
      expect(response.body).to include("Couldn't find Sale with 'id'")
    end
  end

  describe "POST /sales" do
    it "salesを新規作成する" do
      verify_id_token_default_user_stub
      product_id = Product.last.id
      expect {
        post "/api/v1/sales.json", params: 
        {
          sale: {
            product_id: product_id,
            price: 3000,
            publish: true
          }
        }.to_json, headers: headers
      }.to change{Sale.count}.by(1)
      expect(response.status).to eq(200)
    end

    it "パラメータ不足で新規作成失敗する" do
      verify_id_token_default_user_stub
      product_id = Product.last.id
      expect {
        post "/api/v1/sales.json", params: 
        {
          sale: {
            product_id: product_id,
            publish: true
          }
        }.to_json, headers: headers
      }.to change{Sale.count}.by(0)
      expect(response.status).to eq(400)
    end
  end

end
