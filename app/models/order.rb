class Order < ApplicationRecord
  validates :account, presence: true
  validates :sale, presence: true
  validate :forbid_own_product
  validate :forbid_sale_unpublished
  validate :forbid_not_last_sale

  belongs_to :account, foreign_key: "account_id"
  belongs_to :sale, foreign_key: "sale_id"

  def forbid_own_product
    return if self.sale == nil
    return if self.sale.product == nil
    return if self.account == nil
    return if self.account.user == nil
    return if self.account.user != self.sale.product.user
    errors.add(:user, '自分で作った商品を購入することはできません')
  end

  def forbid_sale_unpublished
    return if self.sale == nil
    return if self.sale.publish == nil 
    return if self.sale.publish == true
    errors.add(:sale, '販売情報が現在未公開のため購入することができません')
  end

  def forbid_not_last_sale
    return if self.sale == nil
    return if self.sale.product == nil
    last_sale = Sale.last_sale(self.sale.product) 
    return if last_sale == nil
    return if last_sale == self.sale
    errors.add(:sale, '最新の販売情報でないため購入することができません')
  end
end
