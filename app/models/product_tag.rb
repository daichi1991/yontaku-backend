class ProductTag < ApplicationRecord
  validates :product, presence: true
  validates :tag, presence: true

  belongs_to :product, foreign_key: "product_id"
  belongs_to :tag, foreign_key: "tag_id"
end
