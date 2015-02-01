json.array!(@supplements) do |supplement|
  json.extract! supplement, :id, :award_id, :name, :unit_cost, :quantity, :total_cost
  json.url supplement_url(supplement, format: :json)
end
