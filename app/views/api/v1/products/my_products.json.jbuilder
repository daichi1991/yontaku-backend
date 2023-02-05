json.array! @my_products do |my_product|
  json.id my_product["id"]
  json.name my_product["name"]
  json.description my_product["description"]
  if my_product["sale"]
    json.sale do
      json.price my_product["sale"]["price"]
      json.publish my_product["sale"]["publish"]
    end
  else
    json.sale nil
  end
end