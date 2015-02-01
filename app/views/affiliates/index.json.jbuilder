json.array!(@affiliates) do |affiliate|
  json.extract! affiliate, :id, :name
  json.url affiliate_url(affiliate, format: :json)
end
