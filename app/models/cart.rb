class Cart < ApplicationRecord
  validates :user, presence: true
  validates :sale, presence: true
  validate :forbid_own_product

  belongs_to :user, foreign_key: "user_id"
  belongs_to :sale, foreign_key: "sale_id"

  def forbid_own_product
    return if self.sale != nil && self.sale.product != nil && self.user != self.sale.product.user
    errors.add(:user, '自分で作った商品をカートに入れることはできません')
  end
end
