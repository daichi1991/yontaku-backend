class Question < ApplicationRecord
  validates :product, presence: true
  validates :number, presence: true
  validates :question, presence: true

  belongs_to :product, foreign_key: "product_id"
end
