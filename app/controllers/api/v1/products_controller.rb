class Api::V1::ProductsController < ApplicationController
  before_action :authenticate, only: [:create, :my_products]
  before_action :set_q, only: [:search]

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
    begin
      @product = Product.find(params[:id]).product_with_sale
    rescue => e
      render json: e, status: 400 and return
    end
  end

  def search
    @results = @q
    render :results
  end

  def my_products
    @results = Product.my_products(@current_user)
    render :results
  end

  private
  def set_q
    q = Product.search(params[:q])
    @q = Product.products_with_sale(q)
  end

  def product_params
    params.require(:product).permit(:subject_id, :name, :description).merge(user: @current_user)
  end
end
