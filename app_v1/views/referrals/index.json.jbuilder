json.array!(@referrals) do |referral|
  json.extract! referral, :id, :advocate_email, :referring_physician_id, :prefix, :firstname, :middlename, :lastname, :address, :city, :state, :zip, :home_phone, :work_phone, :contact_name, :contact_phone, :id_num, :date_of_birth, :gender, :married, :employed, :citizen, :household_size, :income, :income_sources
  json.url referral_url(referral, format: :json)
end
