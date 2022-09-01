class Product < ApplicationRecord
  belongs_to :category
  belongs_to :sale_status
  belongs_to :product_status
  belongs_to :user
  has_many :purchases, dependent: :destroy
  has_many :order_details, dependent: :nullify
  has_many :orders, through: :order_details
  has_many :cart_items, dependent: :destroy

  enum category: { 寝具: 1, 時計: 2, 食品: 3, 文具: 4 }

  def self.search(product_name, category_id)
    products = Product.all
    products = products.where('product_name LIKE ?', "%#{product_name}%") if product_name.present?
    products = products.where(category_id: category_id) if category_id.present?
    products
  end
end