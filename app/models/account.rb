class Account < ApplicationRecord
  validates :user, presence: true
  validates :payment_method, presence: true
  validates :active, inclusion: {in: [true, false]}

  belongs_to :user, foreign_key: "user_id"
  belongs_to :payment_method, foreign_key: "payment_method_id"

  has_many :orders
  has_many :defalut_payment_method, -> {default}, class_name: 'PaymentMethod'

  def self.default_create
    create(payment_method: defalut_payment_method, active: true)
  end
end
