class Product < ApplicationRecord
  validates :user, presence: true
  validates :name, presence: true

  belongs_to :user, foreign_key: "user_id"
  belongs_to :subject, foreign_key: "subject_id"

  has_many :questions
  has_many :sales
  has_many :product_tags

  scope :where_user, ->(user) { where(user: user) }

  def last_sale
    sale = Sale.last_sale(self)
    sale_hash = sale.attributes if sale
  end

  def product_with_sale
    product = self.attributes
    product.store('sale', last_sale)
    return product
  end

  def self.products_with_sale(products)
    products_array = products.map(&:attributes)
    products.each_with_index do |product, i|
      products_array[i].store('sale', product.last_sale)
    end
    return products_array
  end

  def self.my_products(user)
    products = where_user(user)
    products_array = products_with_sale(products)
  end

  def self.published_products(products)
    products_array = products_with_sale(products)
    published_products = products_array.select do |product|
      product["sale"] && product["sale"]["publish"] == true
    end
  end

  def self.search(query)
    keywords = query.split(/[\p{blank}\s]+/)
    grouping_hash = keywords.reduce({}){|hash, word| hash.merge(word => { name_cont: word, description_cont: word ,m: "or"})}
    ransack({ combinator: 'and', groupings: grouping_hash}).result
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "name", "updated_at", "user_id"]
  end
end
