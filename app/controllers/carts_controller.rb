class CartsController < ApplicationController
  include SessionsHelper

  def show
    @cart = Cart.find_by(user: current_user)
  end

  def add_item
    cart = Cart.find_by(user: current_user)
    if cart.present?
      cart_item = cart.cart_items.find_by(product_id: params[:product_id])
      if cart_item.present?
        cart_item.quantity += params[:quantity].to_i
        cart_item.save
        flash[:success] = '商品の個数が更新されました。'
        redirect_to cart
      else
        #TODO:paramsの商品と個数を基にカートアイテムを作成
        cart_item = cart.cart_items.new(product_id: params[:product_id], quantity: params[:quantity])
        cart_item.save
        flash[:success] = 'カートに商品が追加されました。'
        redirect_to cart
      end
    else
      #TODO:paramsの商品と個数を元にカートとカートアイテムを作成
      @cart = Cart.new(user: current_user)
      @cart.cart_items.new(product_id: params[:product_id], quantity: params[:quantity])
      if @cart.save
        flash[:success] = 'カートに商品が追加されました。'
        redirect_to @cart
      else
        flash.now[:danger] = @cart.errors.full_messages
        render "products/show"
      end
    end
  end

  #カートアイテム内で個数の更新
  #TODO:UPDATEは別のプルリクで対応
  def update_item
  end

  #    カートアイテムの削除
  def delete_item
    @cart = Cart.find_by(user: current_user)
    @cart.cart_items.find_by(params[:id]).destroy!
    redirect_to @cart
    flash[:success] = 'カート内アイテムを削除しました'
  end
end