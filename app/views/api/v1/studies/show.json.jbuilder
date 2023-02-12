json.id @study.id
json.user @study.user.id
json.product @study.product.id
json.mode @study.mode
json.array! @study.study_detail do |study_detail|
  json
end