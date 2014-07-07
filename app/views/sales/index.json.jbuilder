json.array!(@sales) do |sale|
  json.extract! sale, :id, :sale_name, :description, :price, :genre_id, :display_order, :thumbnail_url, :preview1_url, :preview2_url, :preview3_url, :preview4_url, :preview5_url, :show_flg, :approval_flg, :new_flg, :sale_area, :optimum_plan
  json.url sale_url(sale, format: :json)
end
