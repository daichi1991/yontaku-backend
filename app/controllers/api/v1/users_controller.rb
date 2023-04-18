class Api::V1::UsersController < ApplicationController
  include FirebaseUtils

  before_action :authenticate, only: [:update, :current_user_information, :delete_image]

  def create
    payload = verify_id_token(request.headers["Authorization"]&.split&.last)
    raise ArgumentError, 'BadRequest Parameter' if payload.blank?
    payload_uid = payload['uid']
    raise ArgumentError, '既に存在しているユーザーです' if User.find_by(uid: payload_uid)
    @user = User.create_active_user(payload_uid)
    render :show
  end

  def update
    @user = @current_user
    if @user.update(user_params)
      render :show
    else
      render json: @user.errors, status: 400 and return
    end
  end

  def delete_image
    @user = @current_user
    @user.remove_image!
    if @user.save
      render :show
    else
      render status: 400, json: { status: 400, message: 'Bad Request' }
    end
  end

  def show
    begin
      @user = User.find(params[:id])
    rescue => e
      render json: e, status: 400 and return
    end
  end

  def current_user_information
    @user = @current_user
    if @user
      render :show
    else
      render status: 400, json: { status: 400, message: 'Bad Request' }
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :description, :image, :remove_image)
  end
end
