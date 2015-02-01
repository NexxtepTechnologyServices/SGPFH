json.array!(@medications) do |medication|
  json.extract! medication, :id, :award_id, :id_number, :name, :unit_cost, :quantity, :total_cost
  json.url medication_url(medication, format: :json)
end
