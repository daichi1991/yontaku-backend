class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :uid, presence: true, uniqueness: true
  validates :active, inclusion: {in: [true, false]}
  validates :username, length: {minimum:1, maximum:100}, allow_blank: true

  has_many :products
  has_many :accounts
  has_many :carts
  has_many :rates

  after_create :default_account

  def self.create_active_user(uid)
    new_user = new(uid: uid, active: true)
    transaction do
      new_user.save!
    end
    new_user
  rescue
    raise 'ユーザー作成に失敗しました'
  end

  private

  def default_account
    account = accounts.build(payment_method: PaymentMethod.default, active: true)
    account.save!
  end

end
