json.products @products do |product|
  json.partial! "product", product: product
end