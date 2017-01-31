json.extract! tweet, :id, :status, :body, :zombie_id, :created_at, :updated_at
json.url tweet_url(tweet, format: :json)