class CartItem < ApplicationRecord
  VALID_QUANTITY_REGEX = /\A[0-9]+\z/.freeze

  belongs_to :cart
  belongs_to :product

  #1つの商品の合計の算出
  def sum_of_price
    product.price * quantity
  end

  validates :quantity, presence: true, format: { with: VALID_QUANTITY_REGEX }
end