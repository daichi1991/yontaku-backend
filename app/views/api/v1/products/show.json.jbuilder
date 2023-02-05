json.id @product["id"]
json.name @product["name"]
json.description @product["description"]
if @product["sale"]
  json.sale do
    json.price @product["sale"]["price"]
    json.publish @product["sale"]["publish"]
  end
else
  json.sale nil
end