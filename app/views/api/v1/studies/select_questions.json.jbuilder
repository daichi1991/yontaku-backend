json.array! @select_questions do |select_question|
  json.question select_question[:question]
  json.score select_question[:score]
end
