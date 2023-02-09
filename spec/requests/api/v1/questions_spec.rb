require 'rails_helper'

RSpec.describe "Api::V1::Questions", type: :request do
  before do
    FactoryBot.create(:payment_method, key:'free')
    FactoryBot.create(:user, uid:'abcdefg12345')
    FactoryBot.create(:question)
  end
  let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'hoge_token' } }

  describe "GET /questions/:id" do
    it "特定のquestion情報を取得する" do
      question_id = Question.last.id
      get "/api/v1/questions/#{question_id}.json"
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq question_id
    end

    it "存在しないidでquestion情報にアクセスして失敗" do
      question_id = Question.last.id
      get "/api/v1/questions/#{question_id + 'abc'}.json"
      expect(response.status).to eq(400)
      expect(response.body).to include("Couldn't find Question with 'id'")
    end
  end

  describe "POST /questions" do
    it "新規作成 成功" do
      verify_id_token_default_user_stub
      expect {
        post "/api/v1/questions.json", params: 
        {
          question: {
            product_id: Product.last.id,
            question: "texttexttext"
          }
        }.to_json, headers: headers
      }.to change{Question.count}.by(1)
      expect(response.status).to eq(200)
    end

    it "questionをブランク 失敗" do
      verify_id_token_default_user_stub
      expect {
        post "/api/v1/questions.json", params: 
        {
          question: {
            product_id: Product.last.id,
          }
        }.to_json, headers: headers
      }.to change{Question.count}.by(0)
      expect(response.status).to eq(400)
      expect(response.body).to include("can't be blank")
    end
  end
end
