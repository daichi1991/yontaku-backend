class User < ApplicationRecord
  validates :firebase_local_id, presence: true
  validates :active, presence: true
end
