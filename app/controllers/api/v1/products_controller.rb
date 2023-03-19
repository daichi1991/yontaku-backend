class Api::V1::ProductsController < ApplicationController
  before_action :authenticate, only: [:create, :update,:my_products]
  before_action :set_q, only: [:search]

  def create
    product = Product.new(product_params)
    if product.save
      @product = Product.product_with_info(product)
      render :show
    else
      render json: product.errors, status: 400 and return
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      render json: @product, status: 200 and return
    else
      render json: @product.errors, status: 400 and return
    end
  end

  def show
    begin
      product = Product.find(params[:id])
      @product = Product.product_with_info(product)
    rescue => e
      render json: e, status: 400 and return
    end
  end

  def search
    @products = @q
    render :products
  end

  def search_by_subject
    subject = Subject.find_by(key: params[:subject])
    products = Product.where(subject: subject)
    @products = Product.published_products(products)

    render :products
  end

  def my_products
    @products = Product.my_products(@current_user)
    render :products
  end

  private
  def set_q
    q = Product.search(params[:q])
    @q = Product.published_products(q)
  end

  def product_params
    params.require(:product).permit(:subject_id, :name, :description, :image).merge(user: @current_user)
  end
end
