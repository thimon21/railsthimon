class CartsController < ApplicationController
  include SessionsHelper

  def show
    @cart = Cart.find_by(user: current_user)
  end

  def add_item
    cart = Cart.find_by(user: current_user)
    begin
      # 入力値が数字以外であった場合、params[:quantity],to_iをすると0が返ってくる
      # 入力値が数字以外である場合、かつ個数が0で入力された場合はエラーとした
      raise StandardError, "個数を整数で入力してください" if params[:quantity].to_i.zero?
      if cart.present?
        cart_item = cart.cart_items.find_by(product_id: params[:product_id])
        if cart_item.present?
          cart_item.quantity += params[:quantity].to_i
          if cart_item.save
            flash[:success] = '商品の個数が更新されました。'
            redirect_to cart
          else
            flash.now[:danger] = @cart.errors.full_messages
            render "products/show"
          end
        else
          #TODO:paramsの商品と個数を基にカートアイテムを作成
          cart_item = cart.cart_items.new(product_id: params[:product_id], quantity: params[:quantity])
          if cart_item.save
            flash[:success] = 'カートに商品が追加されました。'
            redirect_to cart
          else
            flash.now[:danger] = @cart.errors.full_messages
            render "products/show"
          end
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
    rescue Exception => error
      # エラーが発生した場合の処理
      # errorには、例外処理で実装したエラーメッセージが入っている
      flash.now[:danger] = error
      render "products/show"
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