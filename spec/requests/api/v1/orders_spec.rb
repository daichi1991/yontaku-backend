require 'rails_helper'

RSpec.describe "Api::V1::Orders", type: :request do
  before do
    @user = FactoryBot.create(:user, uid:'vwxyz12345', active: true)
    @user2 = FactoryBot.create(:user, uid:'abcdefg12345', active: true)
    @product = FactoryBot.create(:product, user: @user)
    @product2 = FactoryBot.create(:product, user: @user)
    @sale = FactoryBot.create(:sale, product: @product, publish: true)
    @sale2 = FactoryBot.create(:sale, product: @product2, publish: true)
    @user_account_id = @user.accounts.last.id
    @user2_account_id = @user2.accounts.last.id
  end
  let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'hoge_token' } }
  describe "POST /orders" do
    context "単体作成" do
      it "新規作成 成功" do
        verify_id_token_default_user_stub
        expect {
          post "/api/v1/orders.json", params:
          {
            order: {
              account_id: @user2_account_id,
              sales:[
                {
                  id: @sale.id
                }
              ]
            }
          }.to_json, headers: headers
        }.to change{Order.count}.by(1)
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json[0]["account_id"]).to eq @user2_account_id
        expect(json[0]["sale_id"]).to eq @sale.id
      end

      it "publish=false 失敗" do
        verify_id_token_default_user_stub
        @sale.update(publish: false)
        expect {
          post "/api/v1/orders.json", params:
          {
            order: {
              account_id: @user2_account_id,
              sales:[
                {
                  id: @sale.id
                }
              ]
            }
          }.to_json, headers: headers
        }.to change{Order.count}.by(0)
        expect(response.status).to eq(400)
        json = JSON.parse(response.body)
        expect(json).to include("販売情報が現在未公開のため購入することができません")
      end

      it "ログインユーザーと異なるaccountで購入 失敗" do
        verify_id_token_stub
        expect {
          post "/api/v1/orders.json", params:
          {
            order: {
              account_id: @user2_account_id,
              sales:[
                {
                  id: @sale.id
                }
              ]
            }
          }.to_json, headers: headers
        }.to change{Order.count}.by(0)
        expect(response.status).to eq(400)
        json = JSON.parse(response.body)
        expect(json).to include("不正なユーザーアクセスです")
      end

      it "自分で作った商品 失敗" do
        verify_id_token_stub
        expect {
          post "/api/v1/orders.json", params:
          {
            order: {
              account_id: @user_account_id,
              sales:[
                {
                  id: @sale.id
                }
              ]
            }
          }.to_json, headers: headers
        }.to change{Order.count}.by(0)
        expect(response.status).to eq(400)
        json = JSON.parse(response.body)
        expect(json).to include("自分で作った商品を購入することはできません")
      end

      it "最新でないsale 失敗" do
        verify_id_token_default_user_stub
        FactoryBot.create(:sale, product: @product, publish: true)
        expect {
          post "/api/v1/orders.json", params:
          {
            order: {
              account_id: @user2_account_id,
              sales:[
                {
                  id: @sale.id
                }
              ]
            }
          }.to_json, headers: headers
        }.to change{Order.count}.by(0)
        expect(response.status).to eq(400)
        json = JSON.parse(response.body)
        expect(json).to include("最新の販売情報でないため購入することができません")
      end
    end

    context "複数作成" do
      it "新規作成 成功" do
        verify_id_token_default_user_stub
        expect {
          post "/api/v1/orders.json", params:
          {
            order: {
              account_id: @user2_account_id,
              sales:[
                {
                  id: @sale.id
                },
                {
                  id: @sale2.id
                },

              ]
            }
          }.to_json, headers: headers
        }.to change{Order.count}.by(2)
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json[0]["account_id"]).to eq @user2_account_id
        expect(json[0]["sale_id"]).to eq @sale.id
        expect(json[1]["account_id"]).to eq @user2_account_id
        expect(json[1]["sale_id"]).to eq @sale2.id
      end

      it "片方が不正 全て失敗" do
        verify_id_token_default_user_stub
        @sale.update(publish: false)
        expect {
          post "/api/v1/orders.json", params:
          {
            order: {
              account_id: @user2_account_id,
              sales:[
                {
                  id: @sale.id
                },
                {
                  id: @sale2.id
                },

              ]
            }
          }.to_json, headers: headers
        }.to change{Order.count}.by(0)
        expect(response.status).to eq(400)
        json = JSON.parse(response.body)
        expect(json).to include("販売情報が現在未公開のため購入することができません")
      end
    end
  end
end
