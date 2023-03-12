class Subject < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :key, presence: true
  validates :name, presence: true

  has_many :products
end
