json.array!(@events) do |event|
  json.extract! event, :id, :name, :description, :begins_at, :ends_at, :website
  json.url event_url(event, format: :json)
end
