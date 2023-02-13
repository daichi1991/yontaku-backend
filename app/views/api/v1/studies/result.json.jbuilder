json.id @result["study"].id
json.user_id @result["study"].user_id
json.product_id @result["study"].product_id
json.mode @result["study"].mode
json.details do
  json.array! @result["details"] do |detail|
    json.study_detail do
      json.id detail["study_detail"].id
      json.skip detail["study_detail"].skip
      json.required_milliseconds detail["study_detail"].required_milliseconds
    end
    json.question do
      json.id detail["question"].id
      json.question detail["question"].question
    end
    json.answer do
      json.id detail["answer"].id
      json.answer detail["answer"].answer
      json.correct detail["answer"].correct
    end
    json.correct_answer do
      json.id detail["correct_answer"].id
      json.answer detail["correct_answer"].answer
    end
  end
end
