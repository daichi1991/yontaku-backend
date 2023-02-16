require 'rails_helper'

RSpec.describe "Api::V1::Answers", type: :request do
  before do
    FactoryBot.create(:payment_method, key:'free')
    FactoryBot.create(:user, uid:'abcdefg12345')
    FactoryBot.create(:answer)
  end
  let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'hoge_token' } }

  describe "GET /answers/:id" do
    it "特定のanswer情報を取得する" do
      answer_id = Answer.last.id
      get "/api/v1/answers/#{answer_id}.json"
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq answer_id
    end

    it "存在しないidでanswer情報にアクセスして失敗" do
      answer_id = Answer.last.id
      get "/api/v1/answers/#{answer_id + 'abc'}.json"
      expect(response.status).to eq(400)
      expect(response.body).to include("Couldn't find Answer with 'id'")
    end
  end

  describe "POST /answers" do
    it "新規作成 成功" do
      verify_id_token_default_user_stub
      question = FactoryBot.create(:question)
      expect {
        post "/api/v1/answers.json", params: 
        {
          answer: {
            question_id: question.id,
            answer: "texttexttext",
            correct: true
          }
        }.to_json, headers: headers
      }.to change{Answer.count}.by(1)
      expect(response.status).to eq(200)
    end

    it "answerをブランク 失敗" do
      verify_id_token_default_user_stub
      expect {
        post "/api/v1/answers.json", params: 
        {
          answer: {
            question_id: Question.last.id,
            correct: true
          }
        }.to_json, headers: headers
      }.to change{Answer.count}.by(0)
      expect(response.status).to eq(400)
      expect(response.body).to include("can't be blank")
    end
  end
end
