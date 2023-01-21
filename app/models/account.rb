class Account < ApplicationRecord
  validates :user, presence: true
  validates :payment_method, presence: true
  validates :active, presence: true

  belongs_to :user, foreign_key: "user_id"
  belongs_to :payment_method, foreign_key: "payment_method_id"

  has_many :orders
end
