class User < ApplicationRecord
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PASSWORD_REGEX = /\A[0-9a-zA-Z]*\Z/.freeze
  VALID_ZIPCODE_REGEX = /\A[0-9]+\z/.freeze
  VALID_PHONE_NUMBER_REGEX = /\A[0-9]+\z/.freeze

  belongs_to :user_classification
  has_many :orders, dependent: :destroy
  has_one :cart, dependent: :destroy

  validates :last_name, presence: true, length: { maximum: 10 }
  validates :first_name, presence: true, length: { maximum: 10 }
  validates :password, presence: true, confirmation: true, format: { with: VALID_PASSWORD_REGEX }, length: { in: 6..15 }
  validates :zipcode, presence: true, format: { with: VALID_ZIPCODE_REGEX }, length: { is: 7 }
  validates :prefecture, presence: true, length: { maximum: 5 }
  validates :municipality, presence: true, length: { maximum: 10 }
  validates :address, presence: true, length: { maximum: 15 }
  validates :apartments, length: { maximum: 20 }
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :phone_number, presence: true, format: { with: VALID_PHONE_NUMBER_REGEX }, length: { maximum: 15 }
end
