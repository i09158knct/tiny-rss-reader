json.array!(@feeds) do |feed|
  json.extract! feed, :title, :url, :feed_url
  json.url feed_url(feed, format: :json)
end