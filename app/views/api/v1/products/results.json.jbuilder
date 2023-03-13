json.array! @results do |result|
  json.id result["id"]
  json.auther_id result["user_id"]
  json.name result["name"]
  json.description result["description"]
  json.image result.image.url
  if result["sale"]
    json.sale do
      json.price result["sale"]["price"]
      json.publish result["sale"]["publish"]
    end
  else
    json.sale nil
  end
end