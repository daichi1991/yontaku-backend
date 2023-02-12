class StudyDetail < ApplicationRecord
  validates :study, presence: true
  validates :question, presence: true
  validates :skip, inclusion: {in: [true, false]}
  validates :required_milliseconds, presence: true

  belongs_to :study, foreign_key: "study_id"
  belongs_to :question, foreign_key: "question_id"
  belongs_to :answer, foreign_key: "answer_id"
end
