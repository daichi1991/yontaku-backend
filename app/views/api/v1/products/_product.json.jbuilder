json.extract! product
json.id product["product"].id
json.name product["product"].name
json.description product["product"].description
json.image product["product"].image.url
json.user do
  json.id product["user"].id
  json.username product["user"].username
end
if product["sale"]
  json.sale do
    json.price product["sale"].price.to_f
    json.publish product["sale"].publish
  end
else
  json.sale nil
end
json.rate do
  json.amount product["rate"][:amount]
  json.score product["rate"][:score]
end
json.question_amount product["question_amount"]