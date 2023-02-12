json.study_id @study.id
json.array! @study.study_detail do |study_detail|
  json.id study_detail.id
end