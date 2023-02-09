class Api::V1::AnswersController < ApplicationController
  before_action :authenticate, only: [:create]

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      render :show
    else
      render json: @answer.errors, status: 400 and return
    end
  end

  def show
    begin
      @answer = Answer.find(params[:id])
    rescue => e
      render json: e, status: 400 and return
    end
  end
  
  private
  def answer_params
    params.require(:answer).permit(:question_id, :answer, :correct)
  end
end
