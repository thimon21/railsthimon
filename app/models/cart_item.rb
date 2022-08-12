class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  #1つの商品の合計の算出
  def sum_of_price
    product.price * quantity
  end
end