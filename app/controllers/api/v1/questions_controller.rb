class Api::V1::QuestionsController < ApplicationController
  before_action :authenticate, only: [:create]

  def create
    @question = Question.new(question_params)
    if @question.save
      render :show
    else
      render json: @question.errors, status: 400 and return
    end
  end

  def show
    begin
      @question = Question.find(params[:id])
    rescue => e
      render json: e, status: 400 and return
    end
  end

  private
  def question_params
    params.require(:question).permit(:product_id, :question)
  end
end
