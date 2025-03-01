json.array! @carts do |cart|
  json.id cart.id
  if cart.sale
    json.sale do
      json.id cart.sale.id
      json.price cart.sale.price
      json.publish cart.sale.publish
    end
  else
    json.sale nil
  end
end