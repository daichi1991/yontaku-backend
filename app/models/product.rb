class Product < ApplicationRecord
  validates :name, presence: true

  belongs_to :user, foreign_key: "user_id"

  has_many :questions
  has_many :sales
  has_many :published_sales, -> { published_sale }, class_name: 'Sale'

  scope :where_user, ->(user) { where(user: user) }

  def published_sale
    published_sales.take
  end

  def self.product_with_sale(user)
    products = where_user(user)
    products_array = products.map(&:attributes)
    products.each_with_index do |product, i|
      sale = Sale.published_sale.attributes
      products_array[i].store('sale', sale)
    end
    return products_array
  end

end
