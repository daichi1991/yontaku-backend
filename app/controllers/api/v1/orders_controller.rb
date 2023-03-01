class Api::V1::OrdersController < ApplicationController
  include FirebaseUtils

  before_action :authenticate, only: [:create]

  def create
    raise Forbidden unless Account.find(order_params[:account_id]).user == @current_user
    raise BadRequest, '販売情報が現在非公開です' if Sale.find(order_params[:sale_id]).publish == false
    order = Order.new(order_params)
    if order.save
      render json: order, status: 201 and return
    else
      render json: order.errors, status: 400 and return
    end
  end

  private
  def order_params
    params.require(:order).permit(:account_id, :sale_id)
  end
end
