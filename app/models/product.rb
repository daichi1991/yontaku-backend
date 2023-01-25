class Product < ApplicationRecord
  validates :name, presence: true

  belongs_to :user, foreign_key: "user_id"

  has_many :question

  scope :where_user, ->(user) { where(user: user) }

end
