json.array!(@stories) do |story|
  json.extract! story, :id, :headline, :body, :user_id
  json.url story_url(story, format: :json)
end
