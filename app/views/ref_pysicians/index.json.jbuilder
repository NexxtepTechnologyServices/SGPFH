json.array!(@ref_pysicians) do |ref_pysician|
  json.extract! ref_pysician, :id, :name
  json.url ref_pysician_url(ref_pysician, format: :json)
end
