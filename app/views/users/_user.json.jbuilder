json.extract! user, :id, :username, :full_name, :photo, :cover_image, :created_at, :updated_at
json.url user_url(user, format: :json)
