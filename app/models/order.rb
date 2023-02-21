class Order < ApplicationRecord
  validates :account, presence: true
  validates :sale, presence: true
  validate :forbid_own_product

  belongs_to :account, foreign_key: "account_id"
  belongs_to :sale, foreign_key: "sale_id"

  def forbid_own_product
    return if self.sale != nil && self.sale.product != nil && self.account != nil  && self.account.user != nil && self.account.user != self.sale.product.user
    errors.add(:user, '自分で作った商品を購入することはできません')
  end
end
