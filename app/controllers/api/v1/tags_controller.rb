class Api::V1::TagsController < ApplicationController
  before_action :authenticate, only: [:create]

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      render json: @tag, status: 200 and return
    else
      render json: @tag.errors, status: 400 and return
    end
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end
end
