json.array! @my_products do |my_product|
  json.name my_product["name"]
  json.description my_product["description"]
  json.sale do
    json.price my_product["sale"]["price"]
    json.publish my_product["sale"]["publish"]
  end
end