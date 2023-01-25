class Api::V1::ProductsController < ApplicationController
  before_action :authenticate

  def my_products
    @my_products = Product.where_user(@current_user)
  end
end
