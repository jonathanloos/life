json.extract! task, :id, :name, :task_list_id, :created_at, :updated_at
json.url task_url(task, format: :json)
