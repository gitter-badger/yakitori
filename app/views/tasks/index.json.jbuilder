json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :description, :user_id, :app_type, :paid, :release_at
  json.url task_url(task, format: :json)
end
