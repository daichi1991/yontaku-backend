class PaymentMethod < ApplicationRecord
    validates :payment_method, presence: true

    has_many :accounts
end
