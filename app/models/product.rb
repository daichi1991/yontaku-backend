class Product < ApplicationRecord
  validates :name, presence: true

  belongs_to :user, foreign_key: "user_id"

  has_many :questions
  has_many :sales

  scope :where_user, ->(user) { where(user: user) }

  def published_sale
    sale = Sale.published_sale(self)
    sale_hash = sale.attributes if sale
  end

  def product_with_sale
    product = self.attributes
    product.store('sale', published_sale)
    return product
  end

  def self.products_with_sale(user)
    products = where_user(user)
    products_array = products.map(&:attributes)
    products.each_with_index do |product, i|
      products_array[i].store('sale', published_sale)
    end
    return products_array
  end

end
