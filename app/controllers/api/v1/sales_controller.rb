class Api::V1::SalesController < ApplicationController
  before_action :authenticate, only: [:create]

  def create
    @sale = Sale.new(sale_params)
    if @sale.save
      render :show
    else
      render json: @sale.errors, status: 400 and return
    end
  end

  def show
    begin
      @sale = Sale.find(params[:id])
    rescue => e
      render json: e, status: 400 and return
    end
  end
  
  private
  def sale_params
    params.require(:sale).permit(:product_id, :price, :publish)
  end
end
