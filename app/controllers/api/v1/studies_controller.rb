class Api::V1::StudiesController < ApplicationController
  before_action :authenticate, only: [:create]

  def create
    @study = Study.new(study_params)
    if @study.save
      render :show
    else
      render json: @study.errors, status: 400 and return
    end
  end

  def create_study_detail
    begin
      study = Study.find(study_params["id"])
      study_detail_params = study_params["study_detail"]
      study_details = study.study_details.build(study_detail_params)
      study_details.each do |study_detail|
        study_detail.save
      end
      @study = Study.find_result(study.id)
      render :show
    rescue => e
      render json: e, status: 400 and return
    end
  end

  def show
    begin
      @study = Study.find(params[:id])
    rescue => e
      render json: e, status: 400 and return
    end
  end

  def result
    begin
      @result = Study.find_result(params[:id])
    rescue => e
      render json: e, status: 400 and return
    end
  end
  
  private
  def study_params
    params.require(:study).permit(:id, :product_id, :mode, study_detail:[:id, :question_id, :answer_id, :skip, :required_milliseconds]).merge(user: @current_user)
  end
end
