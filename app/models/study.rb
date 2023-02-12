class Study < ApplicationRecord
  validates :user, presence: true
  validates :product, presence: true
  validates :mode, presence: true

  belongs_to :user, foreign_key: "user_id"
  belongs_to :product, foreign_key: "product_id"
  has_many :study_details

  enum :mode, {memory: 0, examination: 1}

  def self.find_result(study_id)

    result = {}
    study = Study.find(study_id)
    result.store("study", study)

    study_detail_hash = []
    study_details = study.study_details
    study_details.each_with_index do |study_detail, i|
      details = {}
      details.store("study_detail", study_detail)

      question = study_detail.question
      details.store('question', question)

      answer = study_detail.answer
      details.store('answer', answer)

      # correct_answer = Answer.find_by(question: study_detail.question, correct: true)
      correct_answer = study_detail.question.correct_answer
      details.store('correct_answer', correct_answer)

      study_detail_hash.push(details)
    end

    result.store('details', study_detail_hash)
    
    # binding.pry
    
    return result

  end
end
