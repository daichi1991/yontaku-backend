json.extract! product
json.id product["product"].id
json.name product["product"].name
json.description product["product"].description
json.image product["product"].image.url
if product["sale"]
  json.sale do
    json.price product["sale"].price
    json.publish product["sale"].publish
  end
else
  json.sale nil
end
json.rate do
  json.amount product["rate"][:amount]
  json.socre product["rate"][:score]
end