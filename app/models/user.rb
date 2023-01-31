class User < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  validates :active, inclusion: {in: [true, false]}

  has_many :products
  has_many :accounts
  has_many :carts

  after_create :default_account

  private

  def default_account
    account = accounts.build(payment_method: PaymentMethod.default, active: true)
    account.save
  end

end
