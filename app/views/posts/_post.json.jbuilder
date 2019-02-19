json.extract! post, :id, :title, :article, :likes, :status, :created_at, :updated_at
json.url post_url(post, format: :json)
