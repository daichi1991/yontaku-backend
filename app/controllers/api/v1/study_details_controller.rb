class Api::V1::StudyDetailDetailsController < ApplicationController
  before_action :authenticate, only: [:create]

  def create
    begin
      @study_detail = StudyDetail.create(study_detail_params)
      @study = @study_detail[0].study
      render status: 201
    rescure
      render json: @study_detail.errors, status: 400 and return
    end
  end

  def show
    begin
      @study = Study.find(params[:id])
    rescue => e
      render json: e, status: 400 and return
    end
  end
  
  private
  def study_detail_params
    params.require(:study).permit(:id, study_details: {:question_id, :answer_id, :skip, :required_milliseconds} [])
  end
end
