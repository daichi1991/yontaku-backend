class Rate < ApplicationRecord
  validates :user, presence: true
  validates :product, presence: true
  validates :rate, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validate :forbid_own_product

  belongs_to :user
  belongs_to :product

  def forbid_own_product
    return if self.user == nil
    return if self.product == nil
    return if self.user != self.product.user
    errors.add(:user, '自分で作った商品を評価することはできません')
  end
end
