class Account < ApplicationRecord
  validates :user, presence: true
  validates :payment_method, presence: true
  validates :active, presence: true

  belongs_to :user
  belongs_to :payment_method
end
