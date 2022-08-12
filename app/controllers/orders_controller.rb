class OrdersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  include SessionsHelper

  def new
    @order = Order.new
    @user = current_user
  end

  def create
    @order = Order.new
    @order.user_id = current_user.id
    @order.order_number = p SecureRandom.hex(2)
    if @order.save!
      @cart_items = current_user.cart.cart_items
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new(order_id: @order.id)
        order_detail.order_detail_number = @order.id
        order_detail.product_id = cart_item.product.id
        order_detail.order_quantity = cart_item.quantity
        sub_total_price = cart_item.sum_of_price
        order_detail.shipment_status_id = 1
        order_detail.save!
      end
      current_user.cart.destroy!
      redirect_to orders_purchase_completed_path
    end
  end

  def show
    @order = Order.find_by(id: params[:id])
  end

  def purchase_completed
  end
end
