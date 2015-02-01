json.array!(@transports) do |transport|
  json.extract! transport, :id, :award_id, :number_of_miles, :cost_per_mile, :number_trips
  json.url transport_url(transport, format: :json)
end
