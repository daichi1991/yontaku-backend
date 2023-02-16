json.array! @memory_scores do |memory_score|
  json.question memory_score[:question]
  json.score memory_score[:score]
end
