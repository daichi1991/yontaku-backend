class Study < ApplicationRecord
  validates :user, presence: true
  validates :product, presence: true
  validates :mode, presence: true

  belongs_to :user, foreign_key: "user_id"
  belongs_to :product, foreign_key: "product_id"
  has_many :study_details
end
