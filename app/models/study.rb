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

      correct_answer = study_detail.question.correct_answer
      details.store('correct_answer', correct_answer)

      study_detail_hash.push(details)
    end

    result.store('details', study_detail_hash)

    return result
  end

  def memory_score
    ratio = [40, 30, 20, 10]
    product_id = product.id

    study_details = StudyDetail.joins(:study, :question)
              .where(studies: { user_id: user.id }, questions: { product_id: product_id }, study_details: {score_target: true})
              .order('study_details.created_at desc')

    results = []
    study_details.map do |study_detail|
      question = study_detail.question
      answer = study_detail.answer
      correct_answer = question.correct_answer
      correctness = answer == correct_answer
      same_question_index = results.find_index { |h| h[:question].id == question.id} if results != nil
      
      if same_question_index
        target_correctness = results[same_question_index][:correctness]
        target_correctness.push(correctness) if target_correctness.size < ratio.size
      else
        results.push(
          {
            question: question,
            correctness: [correctness]
          }
        )
      end
    end

    results.each_with_index do |result, index|
      score = 0
      result[:correctness].each_with_index do |correctness, c_index|
        score += ratio[c_index] if correctness == true
      end
      results[index][:score] = score
    end
    results
  end

  def select_questions(question_count)
    question_count_integer = question_count.to_i
    random_question_count = (question_count_integer / 5).floor
    normal_question_count = question_count_integer - random_question_count

    select_questions = memory_score
    select_questions.sort{|a, b| a[:score] <=> b[:score]}
    random_questions = select_questions.slice(normal_question_count, select_questions.size - 1)
    select_questions.slice!(normal_question_count, select_questions.size - 1)
    random_questions.shuffle!.sort{|a, b| a[:score] <=> b[:score]}
    random_questions.slice!(random_question_count, random_questions.size - 1)
    select_questions.concat(random_questions)
    select_questions.shuffle!
  end

end
