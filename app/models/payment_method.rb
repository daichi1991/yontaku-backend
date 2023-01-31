class PaymentMethod < ApplicationRecord
    validates :key, presence: true
    validates :name, presence: true

    has_many :accounts

    scope :default, ->{ find_by(key: 'free') }
end
