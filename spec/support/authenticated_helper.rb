module AuthenticationHelper
  def authenticate_stub
    @test_user = User.find_by(uid: 'abcdefg12345')
    allow_any_instance_of(ApplicationController).to receive(:authenticate).and_return(@test_user)
  end

  def verify_id_token_stub
    @payload = {
      "uid"=>"vwxyz12345",
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

    allow_any_instance_of(ApplicationController).to receive(:verify_id_token).and_return(@payload)
  end

  def verify_id_token_default_user_stub
    @payload = {
      "uid"=>"abcdefg12345",
      "decoded_token"=>{
        :payload=>{
          "iss"=>"https://securetoken.google.com/hoge",
          "aud"=>"hoge",
          "auth_time"=>1675695302,
          "user_id"=>"abcdefg12345",
          "sub"=>"abcdefg12345",
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

    allow_any_instance_of(ApplicationController).to receive(:verify_id_token).and_return(@payload)
  end

  def verify_id_token_blank_stub
    allow_any_instance_of(ApplicationController).to receive(:verify_id_token).and_return(nil)
  end

  def current_user_stub
    @current_user = User.find_by(uid: 'abcdefg12345')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@current_user)
  end
end