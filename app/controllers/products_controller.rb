class ProductsController < ApplicationController
  def show
    @product = Product.find_by(id: params[:id])
  end

  def index
    @products = Product.search(params[:product_name], params[:category_id]).page(params[:page]).per(10)
  end
end
