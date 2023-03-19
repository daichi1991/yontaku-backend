json.array! @subjects do |subject|
  json.key subject[:key]
  json.name subject[:name]
  json.image subject.image.url
end