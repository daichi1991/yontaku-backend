class StudyDetail < ApplicationRecord
  validates :study, presence: true
  validates :question, presence: true
  validates :skip, inclusion: {in: [true, false]}
  validates :required_milliseconds, presence: true
  validates :score_target, inclusion: {in: [true, false]}

  belongs_to :study, foreign_key: "study_id"
  belongs_to :question, foreign_key: "question_id"
  belongs_to :answer, foreign_key: "answer_id"

  after_create :set_false_score_targe

  def set_false_score_targe
    same_question_study_details = StudyDetail.where(question: self.question).order(created_at: "ASC")
    if same_question_study_details.count > 10
      same_question_study_details.first.update(score_target: false)
    end
  end
end
