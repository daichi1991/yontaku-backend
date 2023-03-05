json.array! @results do |result|
  json.id result["id"]
  json.name result["name"]
  json.description result["description"]
  if result["sale"]
    json.sale do
      json.price result["sale"]["price"]
      json.publish result["sale"]["publish"]
    end
  else
    json.sale nil
  end
end