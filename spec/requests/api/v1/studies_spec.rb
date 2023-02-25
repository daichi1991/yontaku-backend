require 'rails_helper'

RSpec.describe "Api::V1::Studies", type: :request do
  before do
    FactoryBot.create(:payment_method, key:'free')
  end
  let(:user) { FactoryBot.create(:user, uid:'abcdefg12345') }
  let(:product) { FactoryBot.create(:product, user: user) }
  let(:questions) { FactoryBot.create_list(:question, 10, product: product) }
  let(:study) { FactoryBot.create(:study, product: product, mode: 0) }
  let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'hoge_token' } }

  describe "GET /studies/:id" do
    it "情報取得 成功" do
      get "/api/v1/studies/#{study.id}.json"
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq study.id
    end

    it "存在しないID 失敗" do
      get "/api/v1/studies/#{study.id + 'abc'}.json"
      expect(response.status).to eq(400)
      expect(response.body).to include("Couldn't find Study with 'id'")
    end
  end

  describe "POST /studies" do
    it "新規作成 成功" do
      verify_id_token_default_user_stub
      expect {
        post "/api/v1/studies.json", params: 
        {
          study: {
            product_id: product.id,
            mode: 0
          }
        }.to_json, headers: headers
      }.to change{Study.count}.by(1)
      expect(response.status).to eq(200)
    end

    it "パラメータ不足 失敗" do
      verify_id_token_default_user_stub
      expect {
        post "/api/v1/studies.json", params: 
        {
          study: {
            product_id: product.id
          }
        }.to_json, headers: headers
      }.to change{Study.count}.by(0)
      expect(response.status).to eq(400)
    end
  end

  describe "POST /studies/create_study_detail" do
    it "成功" do
      verify_id_token_default_user_stub

      answers = []
      questions.each do |question|
        answers.push(FactoryBot.create(:answer, question: question, correct: true))
        3.times do
          answers.push(FactoryBot.create(:answer, question: question, correct: false))
        end
      end
      study_details = []
      skips = []
      10.times do
        skips.push([true, false].sample)
      end
      questions.each_with_index do |question, index|
        study_detail = {
          question_id: question.id,
          answer_id: skips[index] ? nil : answers[rand(index..index+3)].id,
          skip: skips[index],
          required_milliseconds: rand(1..999)
        }
        study_details.push(study_detail)
      end
      expect {
        post "/api/v1/studies/create_study_detail.json", params:
        {
          study: {
            id: study.id,
            study_details:study_details
          }
        }.to_json, headers: headers
      }.to change{StudyDetail.count}.by(10)
      expect(response.status).to eq(200)
    end

    it "skip全てtrue,answer全て値あり 失敗" do
      verify_id_token_default_user_stub

      answers = []
      questions.each do |question|
        answers.push(FactoryBot.create(:answer, question: question, correct: true))
        3.times do
          answers.push(FactoryBot.create(:answer, question: question, correct: false))
        end
      end
      study_details = []
      skips = []
      10.times do
        skips.push([true, false].sample)
      end
      questions.each_with_index do |question, index|
        study_detail = {
          question_id: question.id,
          answer_id: answers[rand(index..index+3)].id,
          skip: skips,
          required_milliseconds: rand(1..999)
        }
        study_details.push(study_detail)
      end
      expect {
        post "/api/v1/studies/create_study_detail.json", params:
        {
          study: {
            id: study.id,
            study_details:study_details
          }
        }.to_json, headers: headers
      }.to change{StudyDetail.count}.by(0)
      expect(response.status).to eq(400)
    end
  end
end
