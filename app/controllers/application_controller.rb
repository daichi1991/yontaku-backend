class ApplicationController < ActionController::API
  include FirebaseUtils

  class AuthenticationError < StandardError; end
  class Forbidden < ActionController::ActionControllerError; end
  class BadRequest < ActionController::BadRequest; end
  rescue_from AuthenticationError, with: :not_authenticate
  rescue_from Forbidden, with: :rescue403
  rescue_from BadRequest, with: :rescue400

  def authenticate
    payload = verify_id_token(request.headers["Authorization"]&.split&.last)
    raise AuthenticationError unless current_user(payload["uid"])
  end

  def current_user(uid = nil)
    @current_user ||= User.find_by(uid: uid)
  end

  def rescue403
    render json: { error: { messages: ["権限の無いユーザー操作です"] } }, status: 403
  end

  def rescue400(e)
    render json: { error: { messages: [e] } }, status: 400
  end

  private
  def not_authenticated
    render json: { error: { messages: ["ログインしてください"] } }, status: :unauthorized
  end

end
