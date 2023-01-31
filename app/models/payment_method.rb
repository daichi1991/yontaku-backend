class PaymentMethod < ApplicationRecord
    validates :key, presence: true
    validates :name, presence: true

    has_many :accounts

    # scope :default, ->{ where(key: 'free') }
end
