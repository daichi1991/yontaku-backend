class Rate < ApplicationRecord
  validates :user, presence: true
  validates :product, presence: true
  validates :rate, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validate :validate_forbid_own_product

  belongs_to :user
  belongs_to :product

  def validate_forbid_own_product
    return if self.user == nil
    return if self.product == nil
    return if self.user != self.product.user
    errors.add(:user, '自分で作った商品を評価することはできません')
  end

  def self.amount(product)
    where(product: product).count
  end

  def self.score(product)
    sum = where(product: product).pluck(:rate).sum
    amount = amount(product)
    return nil if sum == 0
    (sum/amount.to_f*10).round/10.0
  end
end
