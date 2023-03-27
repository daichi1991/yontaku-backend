require 'rails_helper'

RSpec.describe "Api::V1::Tags", type: :request do
  before do
    @user = FactoryBot.create(:user, uid:'vwxyz12345', active: true)
    @user2 = FactoryBot.create(:user, uid:'abcdefg12345', active: true)
    @product = FactoryBot.create(:product, user: @user)
  end
  let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'hoge_token' } }

  describe "POST /tags" do
    it "新規作成 成功" do
      verify_id_token_default_user_stub
      expect {
        post "/api/v1/tags.json", params:
        {
          tag: {
            name: 'sample'
          }
        }.to_json, headers: headers
      }.to change{Tag.count}.by(1)
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["name"]).to eq 'sample'
    end
  end
end
