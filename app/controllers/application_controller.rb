class ApplicationController < ActionController::API
  include FirebaseUtils

  class AuthenticationError < StandardError; end
  class Forbidden < ActionController::ActionControllerError; end
  class BadRequest < ActionController::BadRequest; end
  rescue_from AuthenticationError, with: :not_authenticate
  rescue_from Forbidden, with: :forbidden
  rescue_from BadRequest, with: :bad_request

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

  def forbidden
    render json: { error: { messages: ["権限の無いユーザー操作です"] } }, status: :forbidden
  end

  def bad_request(e)
    render json: { error: { messages: [e] } }, status: :bad_request
  end

end
