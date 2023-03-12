class Api::V1::SubjectsController < ApplicationController
  before_action :authenticate, only: [:create, :update]

  def index
    @subject = Subject.all
    render json: @subject, status: 200 and return
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      render json: @subject, status: 200 and return
    else
      render json: @subject, status: 400 and return
    end
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update(subject_params)
      render json: @subject, status: 200 and return
    else
      render json: @subject, status: 400 and return
    end
  end

  private
  def subject_params
    params.require(:subject).permit(:key, :name, :image)
  end
end
