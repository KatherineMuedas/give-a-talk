json.array!(@organizations) do |organization|
  json.extract! organization, :id, :name, :website, :about, :user_id
  json.url organization_url(organization, format: :json)
end
