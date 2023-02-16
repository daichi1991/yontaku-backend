class Question < ApplicationRecord
  validates :product, presence: true
  validates :question, presence: true

  belongs_to :product, foreign_key: "product_id"
  has_many :answers
  has_many :study_details

  def correct_answer
    Answer.find_by(question: self, correct: true)
  end
end
