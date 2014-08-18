json.array!(@sale_categories) do |sale_category|
  json.extract! sale_category, :id, :name, :label
  json.url sale_category_url(sale_category, format: :json)
end
