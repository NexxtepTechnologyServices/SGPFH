json.array!(@ref_meds) do |ref_med|
  json.extract! ref_med, :id, :drug, :icd9, :diagnosis, :doscage, :sig, :dispense, :refills, :referral_id
  json.url ref_med_url(ref_med, format: :json)
end
