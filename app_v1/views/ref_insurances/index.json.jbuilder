json.array!(@ref_insurances) do |ref_insurance|
  json.extract! ref_insurance, :id, :name
  json.url ref_insurance_url(ref_insurance, format: :json)
end
