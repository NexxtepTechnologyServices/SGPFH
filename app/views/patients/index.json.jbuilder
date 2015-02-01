json.array!(@patients) do |patient|
  json.extract! patient, :id, :first_name, :last_name, :middle, :birthday, :address1, :address2, :city, :state, :zip
  json.url patient_url(patient, format: :json)
end
