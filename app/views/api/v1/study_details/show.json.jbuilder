json.study_detail_id @study_detail.id
json.study do
  json.id @study_detail.study.id
  json.product @study_detail.study.product.id
  json.mode @study_detail.study.mode
end
json.question do
  json.id @study_detail.question.id
  json.question @study_detail.question.question
end
json.answer do
  json.id @study_detail.answer.id
  json.answer @study_detail.answer.id
  json.correct @study_detail.answer.correct
end
json.skip @study_detail.skip
json.required_milliseconds @study_detail.required_milliseconds