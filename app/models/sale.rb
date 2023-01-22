class Sale < ApplicationRecord
  validates :price, presence: true
  validates :publish, inclusion: {in: [true, false]}

  belongs_to :product, foreign_key: "product_id"

  has_many :carts
  has_many :orders
end
