require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  before do
    FactoryBot.create(:payment_method, key:'free')
    FactoryBot.create(:user, uid:'abcdefg12345')
    FactoryBot.create(:product)
  end
  let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'hoge_token' } }

  describe "GET /products/:id" do
    it "特定のproduct情報を取得する" do
      product_id = Product.last.id
      get "/api/v1/products/#{product_id}.json"
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq product_id
    end

    it "存在しないidでproduct情報にアクセスして失敗" do
      product_id = Product.last.id
      get "/api/v1/products/#{product_id + 'abc'}.json"
      expect(response.status).to eq(400)
      expect(response.body).to include("Couldn't find Product with 'id'")
    end
  end

  describe "POST /products" do
    it "新規作成 成功" do
      verify_id_token_default_user_stub
      expect {
        post "/api/v1/products.json", params: 
        {
          product: {
            name: "product_name",
            description: "texttexttext",
          }
        }.to_json, headers: headers
      }.to change{Product.count}.by(1)
      expect(response.status).to eq(200)
    end

    it "nameをブランク 失敗" do
      verify_id_token_default_user_stub
      expect {
        post "/api/v1/products.json", params: 
        {
          product: {
            description: "texttexttext",
          }
        }.to_json, headers: headers
      }.to change{Product.count}.by(0)
      expect(response.status).to eq(400)
      expect(response.body).to include("can't be blank")
    end
  end

  describe "GET /products/my_products" do
    it "my_productsを取得する" do
      verify_id_token_default_user_stub
      FactoryBot.create(:product, name: "my_product", user: User.find_by(uid: "abcdefg12345"))
      get "/api/v1/products/my_products.json", headers: headers
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json[0]["name"]).to eq "my_product"
    end
  end
end
