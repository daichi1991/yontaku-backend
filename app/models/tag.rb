class Tag < ApplicationRecord
    validates :name, presence: true

    has_many :product_tags
end
