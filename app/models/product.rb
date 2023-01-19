class Product < ApplicationRecord
  validates :name, presence: true

  belongs_to :user, foreign_key: "user_id"
end
