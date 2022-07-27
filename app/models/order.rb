class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy

  def total_price
    order_details.sum(&:sub_total_price)
  end

  def find_order_shipment_status
    if order_details.any? {|order_detail| order_detail.shipment_status.shipment_status_name == '準備中'}
      "準備中"
    else
      "発送済"
    end
  end
end