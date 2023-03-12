json.array! @subjects do |subject|
  json.name subject[:name]
  json.image subject.image.url
end