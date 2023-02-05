class Api::V1::ProductsController < ApplicationController
  before_action :authenticate, only: [:create, :my_product]

  def create
    product = Product.create(product_params)
    @product = Product.find(product.id).product_with_sale
    render :show
  end

  def show
    @product = Product.find(params[:id]).product_with_sale
  end

  def my_products
    @my_products = Product.products_with_sale(@current_user)
  end

  private
  def product_params
    params.require(:product).permit(:name, :description).merge(user: @current_user)
  end
end
