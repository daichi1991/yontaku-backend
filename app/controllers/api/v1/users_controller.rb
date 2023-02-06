class Api::V1::UsersController < ApplicationController
  include FirebaseUtils

  before_action :authenticate, only: :show

  def create
    payload = verify_id_token(request.headers["Authorization"]&.split&.last)
    raise ArgumentError, 'BadRequest Parameter' if payload.blank?
    payload_uid = payload['uid']
    raise ArgumentError, '既に存在しているユーザーです' if User.find_by(uid: payload_uid)
    @user = User.create_active_user(payload_uid)
    render :show
  end

  def show
    begin
      @user = User.find(params[:id])
    rescue => e
      render json: e, status: 400 and return
    end
  end
end
