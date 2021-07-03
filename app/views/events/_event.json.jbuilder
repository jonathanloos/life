json.extract! event, :id, :user_id, :start_date, :name, :end_date, :created_at, :updated_at
json.url event_url(event, format: :json)
