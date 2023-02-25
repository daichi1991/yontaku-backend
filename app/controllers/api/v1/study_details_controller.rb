class Api::V1::StudyDetailsController < ApplicationController
  before_action :authenticate

  def show
    begin
      @study_detail = StudyDetail.find(params[:id])
    rescue => e
      render json: e, status: 400 and return
    end
  end
end
