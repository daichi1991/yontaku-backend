class User < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  validates :active, inclusion: {in: [true, false]}

  has_many :products
  has_many :accounts
  has_many :carts

  after_create :default_account

  def self.create_active_user(uid)
    new_user = new(uid: uid, active: true)
    transaction do
      new_user.save!
    end
    new_user
  rescue
    raise ArgumentError, 'ユーザー作成に失敗しました'
  end

  private

  def default_account
    account = accounts.build(payment_method: PaymentMethod.find(99), active: true)
    account.save!
  end

end
