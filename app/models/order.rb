class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details

  def total_price
    order_details.sum(&:sub_total_price)
  end

  def order_shipment_status
    if order_details.any? {|order_detail| order_detail.shipment_status.shipment_status_name == '準備中'}
      "準備中"
    else
      "発送済"
    end
  end

  def self.hex(n=nil)
    random_bytes(n).unpack("H*")[0]
  end
end