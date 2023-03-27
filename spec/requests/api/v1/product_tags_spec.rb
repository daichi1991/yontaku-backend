require 'rails_helper'

RSpec.describe "Api::V1::ProductTags", type: :request do
  before do
    @user = FactoryBot.create(:user, uid:'vwxyz12345', active: true)
    @user2 = FactoryBot.create(:user, uid:'abcdefg12345', active: true)
    @product = FactoryBot.create(:product, user: @user)
    @tag = FactoryBot.create(:tag)
  end
  let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'hoge_token' } }

  describe "POST /product_tags" do
    it "新規作成 成功" do
      verify_id_token_default_user_stub
      expect {
        post "/api/v1/product_tags.json", params:
        {
          product_tag: {
            product_id: @product.id,
            tag_id: @tag.id
          }
        }.to_json, headers: headers
      }.to change{ProductTag.count}.by(1)
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["product_id"]).to eq @product.id
      expect(json["tag_id"]).to eq @tag.id
    end
  end
end
