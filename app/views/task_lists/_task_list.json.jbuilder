json.extract! task_list, :id, :name, :tasks_id, :created_at, :updated_at
json.url task_list_url(task_list, format: :json)
