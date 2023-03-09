class Subject < ApplicationRecord
  validates :key, presence: true
  validates :name, presence: true

  has_many :products
end
