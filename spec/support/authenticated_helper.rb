module AuthenticationHelper
  def authenticate_stub
    # 渡したいインスタンス変数を定義
    @current_user = User.find_by(uid: 'abcdefg12345')

    # allow_any_instance_ofメソッドを使ってauthenticate!メソッドが呼ばれたら
    # ↑のインスタンス変数を返す
    allow_any_instance_of(ApplicationController).to receive(:authenticate).and_return(nil)
  end

  def verify_id_token_stub
    @payload = {
      "uid"=>"dIDmLB7njIObdkEREM9XRpdcamZ2",
      "decoded_token"=>{
        :payload=>{
          "iss"=>"https://securetoken.google.com/hoge",
          "aud"=>"hoge",
          "auth_time"=>1675695302,
          "user_id"=>"vwxyz12345",
          "sub"=>"vwxyz12345",
          "iat"=>1675695303,
          "exp"=>1675698903,
          "email"=>"sample@sample.com",
          "email_verified"=>false,
          "firebase"=>{
            "identities"=>{
              "email"=>["sample@sample.com"]
            }, 
            "sign_in_provider"=>"password"
          }
        },
        :header=>{
          "alg"=>"RS256",
          "kid"=>"5a509f019f70d779d80f152d1a5d33811ab7cef7",
          "typ"=>"JWT"
        }
      }
    }

    allow_any_instance_of(Api::V1::UsersController).to receive(:verify_id_token).and_return(@payload)
  end
end