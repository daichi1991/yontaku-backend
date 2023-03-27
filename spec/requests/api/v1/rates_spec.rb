require 'rails_helper'

RSpec.describe "Api::V1::Rates", type: :request do
  before do
    @user = FactoryBot.create(:user, uid:'vwxyz12345', active: true)
    @user2 = FactoryBot.create(:user, uid:'abcdefg12345', active: true)
    @product = FactoryBot.create(:product, user: @user)
  end
  let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'hoge_token' } }
  
  describe "POST /rates" do
    it "新規作成 成功" do
      verify_id_token_default_user_stub
      expect {
        post "/api/v1/rates.json", params:
        {
          rate: {
            product_id: @product.id,
            rate: 3
          }
        }.to_json, headers: headers
      }.to change{Rate.count}.by(1)
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["rate"]).to eq 3
    end
  end

  describe "PUT /rates" do
    it "新規作成 成功" do
      rate = FactoryBot.create(:rate, user: @user2, product: @product, rate: 3)
      verify_id_token_default_user_stub
      expect {
        put "/api/v1/rates/#{rate.id}.json", params:
        {
          rate: {
            rate: 5
          }
        }.to_json, headers: headers
      }.to change{Rate.count}.by(0)
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["rate"]).to eq 5
    end
  end
end
