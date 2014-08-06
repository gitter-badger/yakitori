json.array!(@products) do |product|
  json.extract! product, :id, :product_name, :version, :genre_id, :thumbnail_url, :product_data_url, :category_id, :package_id
  json.url product_url(product, format: :json)
end
