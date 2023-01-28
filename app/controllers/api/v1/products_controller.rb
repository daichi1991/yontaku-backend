class Api::V1::ProductsController < ApplicationController
  before_action :authenticate

  def my_products
    @my_products = Product.product_with_sale(@current_user)
  end
end
