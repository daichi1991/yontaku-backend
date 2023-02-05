class Api::V1::ProductsController < ApplicationController
  before_action :authenticate, only: [:create, :my_products]

  def create
    product = Product.new(product_params)
    if product.save
      @product = product.product_with_sale
      render :show
    else
      render json: product.errors, status: 400 and return
    end
  end

  def show
    @product = Product.find(params[:id]).product_with_sale
  end

  def my_products
    @my_products = Product.my_products(@current_user)
  end

  private
  def product_params
    params.require(:product).permit(:name, :description).merge(user: @current_user)
  end
end
