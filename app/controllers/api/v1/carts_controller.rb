class Api::V1::CartsController < ApplicationController
  before_action :authenticate, only: [:create]

  def create
    @cart = Cart.new(cart_params)
    if @cart.save
      render :show
    else
      render json: @cart.errors. status: 400 and return
    end
  end

  private
  def cart_params
    params.require(:cart).permit(:sale).merge(user: @current_user)
  end
end
