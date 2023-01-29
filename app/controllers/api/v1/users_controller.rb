class Api::V1::UsersController < ApplicationController
  include FirebaseUtils

  before_action :authenticate, only: :show

  def create
    
    binding.pry
    
    payload = verify_id_token(request.headers["Authorization"]&.split&.last)
    raise ArgumentError, 'BadRequest Parameter' if payload.blank?
    @user = User.create!(uid: payload['uid'], active: true)
    render :show
  end

  def show
    @user = current_user
  end
end
