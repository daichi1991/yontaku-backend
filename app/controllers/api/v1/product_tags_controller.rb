class Api::V1::ProductTagsController < ApplicationController
  before_action :authenticate, only: [:create]

  def create
    @product_tag = ProductTag.create(product_tag_params)
    if @product_tag.save
      render json: @product_tag, status: 200 and return
    else
      render json: @product_tag.errors, status: 400 and return
    end
  end

  private
  def product_tag_params
    params.require(:product_tag).permit(:product_id, :tag_id)
  end
end
