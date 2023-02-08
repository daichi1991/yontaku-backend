require 'rails_helper'

RSpec.describe "Api::V1::Sales", type: :request do
  before do
    FactoryBot.create(:payment_method, key:'free')
    user = FactoryBot.create(:user, uid:'abcdefg12345')
    product = FactoryBot.create(:product, user: user)
    FactoryBot.create(:sale, product: product)
  end
  let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'hoge_token' } }

  describe "GET /sales/:id" do
    it "特定のsales情報を取得する" do
      sales_id = Sale.last.id
      get "/api/v1/sales/#{sales_id}.json"
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq sales_id
    end

    it "特定のsales情報を取得する" do
      sales_id = Sale.last.id
      get "/api/v1/sales/#{sales_id + 'abc'}.json"
      expect(response.status).to eq(400)
      expect(response.body).to include("Couldn't find Sale with 'id'")
    end
  end

  describe "POST /sales" do
    it "productを新規作成する" do
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
  end

end
