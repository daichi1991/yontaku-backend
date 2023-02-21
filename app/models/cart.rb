class Cart < ApplicationRecord
  validates :user, presence: true
  validates :sale, presence: true
  validate :forbid_own_product
  validate :forbid_same_sale
  validate :forbid_same_product

  belongs_to :user, foreign_key: "user_id"
  belongs_to :sale, foreign_key: "sale_id"

  def forbid_own_product
    return if self.sale != nil && self.sale.product != nil && self.user != self.sale.product.user
    errors.add(:user, '自分で作った商品をカートに入れることはできません')
  end

  def forbid_same_sale
    return if Cart.where(user: self.user, sale: self.sale).count == 0
    errors.add(:base, '既にカートに入っています')
  end

  def forbid_same_product
    return if self.sale != nil && self.sale.product != nil && Cart.includes(:sale).where(carts: {user: self.user}, sales: {product: self.sale.product}).count == 0
    errors.add(:base, '同じ商品をカートに入れることはできません')
  end
end
