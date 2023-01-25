class ApplicationController < ActionController::API
  include FirebaseUtils

  class AuthenticationError < StandardError; end
  rescue_from AuthenticationError, with: :not_authenticated

  def authenticate
    payload = verify_id_token(request.headers["Authorization"]&.split&.last)
    raise AuthenticationError unless current_user(payload["uid"])
  end

  def current_user(uid = nil)
    @current_user ||= User.find_by(uid: uid)
  end

  private
  def not_authenticated
    render json: { error: { messages: ["ログインしてください"] } }, status: :unauthorized
  end

end
