class Cart < ApplicationRecord
  validates :user, presence: true
  validates :sale, presence: true

  belongs_to :user, foreign_key: "user_id"
  belongs_to :sale, foreign_key: "sale_id"
end
