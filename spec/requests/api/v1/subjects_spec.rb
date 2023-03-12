require 'rails_helper'
require 'fileutils'

RSpec.describe "Api::V1::Subjects", type: :request do
  before do
    FactoryBot.create(:payment_method, key:'free')
    FactoryBot.create(:user, uid:'abcdefg12345')
    FactoryBot.create_list(:subject, 3)
  end
  let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'hoge_token' } }

  after do
    subjects = Subject.all
    subjects.each do |subject|
      dir_name = subject.id
      FileUtils.rm_rf("public/uploads/subject/image/#{dir_name}")
    end
  end
  describe "GET /subjects" do
    it "一覧取得 成功" do
      get "/api/v1/subjects.json"
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json.count).to eq 3
    end
  end

  describe "POST /subjects" do
    it "新規作成 成功" do
      verify_id_token_default_user_stub
      file = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/images/test.jpg'), 'image/jpg')
      expect {
        post "/api/v1/subjects.json", params: 
        {
          subject: {
            key: 'test',
            name: 'テスト',
            image: file
          }
        }.to_json, headers: headers
      }.to change{Subject.count}.by(1)
      ## ファイルアップロードのテストがうまく行かないので後ほど実装
    end
  end

  describe "PUT /subjects/:id" do
    it "データ更新 成功" do
      verify_id_token_default_user_stub
      subject = FactoryBot.create(:subject, key:'abcdef')
      expect {
        put "/api/v1/subjects/#{subject.id}.json", params: 
        {
          subject: {
            key: 'test',
            name: 'テスト',
            image: nil
          }
        }.to_json, headers: headers
      }.to change{Subject.count}.by(0)
      json = JSON.parse(response.body)
      expect(json["key"]).to eq 'test'
    end
  end
end
