json.id @cart.id
if @cart.sale
  json.sale do
    json.price @cart.sale.price
    json.publish @cart.sale.publish
  end
else
  json.sale nil
end