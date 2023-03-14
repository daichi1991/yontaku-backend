class Api::V1::RatesController < ApplicationController
  before_action :authenticate, only: [:create, :update]

  def create
    @rate = Rate.new(rate_params)
    if @rate.save
      render json: @rate, status: 200 and return
    else
      render json: @rate.errors, status: 400 and return
    end
  end

  def update
    @rate = Rate.find(params[:id])
    if @rate.update(rate_params)
      render json: @rate, status: 200 and return
    else
      render json: @rate, status: 400 and return
    end
  end

  private
  def rate_params
    params.require(:rate).permit(:product_id, :rate).merge(user: @current_user)
  end
end
