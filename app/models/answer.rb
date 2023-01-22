class Answer < ApplicationRecord
  validates :question, presence: true
  validates :answer, presence: true
  validates :correct, inclusion: {in: [true, false]}
  validate :correct_answer_already_exist

  belongs_to :question, foreign_key: "question_id"

  private

  def correct_answer_already_exist
    return if Answer.where(question: self.question, correct: true).count == 0
    errors.add(:correct, 'この問題には既に正答が存在しています') if self.correct == true
  end

end
