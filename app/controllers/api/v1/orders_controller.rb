class Api::V1::OrdersController < ApplicationController
  include FirebaseUtils

  before_action :authenticate, only: [:create]

  def create
    raise Forbidden unless Account.find(order_params[:account_id]).user == @current_user
    orders = []
    Order.transaction do
      order_params[:sales].each do |sale|
        order = Order.new(account_id: order_params[:account_id], sale_id: sale[:id])
        order.save!
        orders.push(order)
      end
    end
    render json: orders, status: 201 and return
    rescue => e
      render json: e, status: 400 and return
  end

  private
  def order_params
    params.require(:order).permit(:account_id, sales:[:id])
  end
end
