class User < ApplicationRecord
  validates :firebase_local_id, presence: true
  validates :active, inclusion: {in: [true, false]}

  has_many :products
  has_many :accounts
  has_many :carts
end
