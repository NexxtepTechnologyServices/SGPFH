json.array!(@awards) do |award|
  json.extract! award, :id, :patient_id, :award_type, :total_requested, :total_granted, :description
  json.url award_url(award, format: :json)
end
