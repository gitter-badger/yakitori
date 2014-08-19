json.array!(@genres) do |genre|
  json.extract! genre, :id, :name, :pay_label, :free_label
  json.url genre_url(genre, format: :json)
end
