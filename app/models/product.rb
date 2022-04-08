class Product < ApplicationRecord
    belongs_to :category
    belongs_to :sale_status
    belongs_to :product_status
    belongs_to :user
    has_many :purchases, dependent: :destroy
end
