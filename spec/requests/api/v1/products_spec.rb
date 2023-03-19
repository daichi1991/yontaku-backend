require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  before do
    FactoryBot.create(:payment_method, key:'free')
    FactoryBot.create(:user, uid:'abcdefg12345')
    FactoryBot.create(:subject)
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
      subject = Subject.last
      expect {
        post "/api/v1/products.json", params: 
        {
          product: {
            subject_id: subject.id,
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

  describe "PUT /products" do
    it "update 成功" do
      verify_id_token_default_user_stub
      product_id = Product.last.id
      expect {
        put "/api/v1/products/#{product_id}.json", params: 
        {
          product: {
            name: "updated_product_name",
            description: "updated_text",
          }
        }.to_json, headers: headers
      }.to change{Product.count}.by(0)
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["name"]).to eq "updated_product_name"
    end

    it "nameをブランク 失敗" do
      verify_id_token_default_user_stub
      expect {
        post "/api/v1/products.json", params: 
        {
          product: {
            name: nil,
          }
        }.to_json, headers: headers
      }.to change{Product.count}.by(0)
      expect(response.status).to eq(400)
      json = JSON.parse(response.body)
      expect(json["name"]).to include("can't be blank")
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

  describe "GET /products/search" do
    before do
      Product.last.destroy
    end
    context "1レコード" do
      before do
        product = FactoryBot.create(:product, name: "my_product", description: "great learning", user: User.find_by(uid: "abcdefg12345"))
        FactoryBot.create(:sale, product: product, publish: true)
      end
      it "nameで検索" do
        query = "pro"
        get "/api/v1/products/search.json?q=#{query}", headers: headers
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json[0]["name"]).to eq "my_product"
      end

      it "descriptionで検索" do
        query = "great"
        get "/api/v1/products/search.json?q=#{query}", headers: headers
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json[0]["name"]).to eq "my_product"
      end

      it "存在しないキーワードで検索" do
        query = "test"
        get "/api/v1/products/search.json?q=#{query}", headers: headers
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json).to eq []
      end
    end

    context "複数レコードから検索" do
      before do
        @product1 = FactoryBot.create(:product, name: "first", description: "great learning test", user: User.find_by(uid: "abcdefg12345"))
        @product2 = FactoryBot.create(:product, name: "second", description: "great product test", user: User.find_by(uid: "abcdefg12345"))
        @product3 = FactoryBot.create(:product, name: "third", description: "good memory for you", user: User.find_by(uid: "abcdefg12345"))
        FactoryBot.create(:sale, product: @product1, publish: true)
        FactoryBot.create(:sale, product: @product2, publish: true)
        FactoryBot.create(:sale, product: @product3, publish: true)
      end
      context "キーワード一つ" do
        it "0レコードヒット" do
          query = "zero"
          get "/api/v1/products/search.json?q=#{query}", headers: headers
          expect(response.status).to eq(200)
          json = JSON.parse(response.body)
          expect(json).to eq []
        end

        it "1レコードヒット" do
          query = "first"
          get "/api/v1/products/search.json?q=#{query}", headers: headers
          expect(response.status).to eq(200)
          json = JSON.parse(response.body)
          expect(json[0]["name"]).to eq "first"
          expect(json[1]).to eq nil
        end

        it "2レコードヒット" do
          query = "great"
          get "/api/v1/products/search.json?q=#{query}", headers: headers
          expect(response.status).to eq(200)
          json = JSON.parse(response.body)
          expect(json[0]["name"]).to eq "first"
          expect(json[1]["name"]).to eq "second"
        end
      end

      context "複数キーワード" do
        it "0レコードヒット" do
          query = "first second"
          get "/api/v1/products/search.json?q=#{query}", headers: headers
          expect(response.status).to eq(200)
          json = JSON.parse(response.body)
          expect(json).to eq []
        end

        it "1レコードヒット" do
          query = "first great"
          get "/api/v1/products/search.json?q=#{query}", headers: headers
          expect(response.status).to eq(200)
          json = JSON.parse(response.body)
          expect(json[0]["name"]).to eq "first"
          expect(json[1]).to eq nil
        end

        it "2レコードヒット" do
          query = "great test"
          get "/api/v1/products/search.json?q=#{query}", headers: headers
          expect(response.status).to eq(200)
          json = JSON.parse(response.body)
          expect(json[0]["name"]).to eq "first"
          expect(json[1]["name"]).to eq "second"
          expect(json[2]).to eq nil
        end
      end

      context "sale publish" do
        it "true 1レコードヒット" do
          FactoryBot.create(:sale, product: @product1, publish: false)
          query = "great"
          get "/api/v1/products/search.json?q=#{query}", headers: headers
          expect(response.status).to eq(200)
          json = JSON.parse(response.body)
          expect(json[0]["name"]).to eq "second"
          expect(json[1]).to eq nil
        end
      end
    end
  end

  describe "GET /products/search_by_subject" do
    before do
      subject1 = FactoryBot.create(:subject, key: 'english')
      subject2 = FactoryBot.create(:subject, key: 'history')
      product1_1 = FactoryBot.create(:product, subject: subject1, name: "english_1", user: User.find_by(uid: "abcdefg12345"))
      product1_2 = FactoryBot.create(:product, subject: subject1, name: "english_2", user: User.find_by(uid: "abcdefg12345"))
      product2_1 = FactoryBot.create(:product, subject: subject2, name: "history_1", user: User.find_by(uid: "abcdefg12345"))
      product2_2 = FactoryBot.create(:product, subject: subject2, name: "history_2", user: User.find_by(uid: "abcdefg12345"))
      FactoryBot.create(:sale, product: product1_1, publish: true)
      FactoryBot.create(:sale, product: product1_2, publish: true)
      FactoryBot.create(:sale, product: product2_1, publish: true)
      FactoryBot.create(:sale, product: product2_2, publish: true)
    end
    context "存在するキーワード" do
      it "english" do
        query = "english"
        get "/api/v1/products/search_by_subject.json?subject=#{query}", headers: headers
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json[0]["name"]).to eq "english_1"
        expect(json[1]["name"]).to eq "english_2"
      end
    end
    context "存在しないキーワード" do
      it "notexist" do
        query = "notexist"
        get "/api/v1/products/search_by_subject.json?subject=#{query}", headers: headers
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json).to eq []
      end
    end
  end
end
