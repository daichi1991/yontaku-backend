class Question < ApplicationRecord
  validates :product, presence: true
  validates :question, presence: true

  belongs_to :product, foreign_key: "product_id"
  has_many :answers
end
