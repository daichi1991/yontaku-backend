class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :user, presence: true
  validates :name, presence: true

  belongs_to :user, foreign_key: "user_id"
  belongs_to :subject, foreign_key: "subject_id"

  has_many :questions
  has_many :sales
  has_many :product_tags
  has_many :rates

  scope :where_user, ->(user) { where(user: user) }

  def self.last_sale(product)
    sale = Sale.last_sale(product)
  end

  def self.product_with_info(product)
    result = {}
    result.store('product', product)
    result.store('sale', last_sale(product))
    return result
  end

  def self.products_with_info(products)
    products_array = []
    
    products.each do |product|
      product_hash = product_with_info(product)
      products_array.push(product_hash)
    end

    return products_array
  end

  def self.my_products(user)
    products = where_user(user)
    products_array = products_with_info(products)
  end

  def self.published_products(products)
    products_array = products_with_info(products)
    
    published_products = products_array.select do |product|
      product["sale"] && product["sale"].publish == true
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
