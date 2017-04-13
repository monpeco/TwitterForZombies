json.extract! photo, :id, :name, :score, :created_at, :updated_at
json.url photo_url(photo, format: :json)