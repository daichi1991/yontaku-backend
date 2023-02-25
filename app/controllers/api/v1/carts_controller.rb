class Api::V1::CartsController < ApplicationController
  before_action :authenticate, only: [:create, :current_user_cart]

  def create
    @cart = Cart.new(cart_params)
    if @cart.save
      render :show
    else
      render json: @cart.errors, status: 400 and return
    end
  end

  def current_user_cart
    @carts = Cart.where(user: @current_user)
    render :current_user_cart
  end

  private
  def cart_params
    params.require(:cart).permit(:sale_id).merge(user: @current_user)
  end
end
