class Order < ApplicationRecord
  validates :account, presence: true
  validates :sale, presence: true

  belongs_to :account, foreign_key: "account_id"
  belongs_to :sale, foreign_key: "sale_id"
end
