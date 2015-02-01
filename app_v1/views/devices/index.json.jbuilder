json.array!(@devices) do |device|
  json.extract! device, :id, :award_id, :name, :device_type, :unit_cost, :quantity, :total_cost
  json.url device_url(device, format: :json)
end
