json.array!(@notes) do |note|
  json.extract! note, :id, :content, :referral_id
  json.url note_url(note, format: :json)
end