if @my_products.exists?
    json.array!(@my_products) do |my_product|
        json.(my_product, :id, :name, :description)
    end
end