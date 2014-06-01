json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :year
  json.url movie_url(movie, format: :json)
end
