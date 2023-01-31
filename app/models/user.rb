class User < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  validates :active, inclusion: {in: [true, false]}

  has_many :products
  has_many :accounts
  has_many :carts
end
