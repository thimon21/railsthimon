class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  #1つの商品の合計の算出
  def sum_of_price
    product.price * quantity
  end
end