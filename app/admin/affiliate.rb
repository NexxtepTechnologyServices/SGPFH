ActiveAdmin.register Affiliate do

  before_save do |affiliate|
  	affiliate.slug = Digest::MD5.hexdigest("#{affiliate.id}#{affiliate.email}")
  end

  permit_params do
    permitted = [:name, :email,:get_email,:slug,:created_at, :updated_at]
    permitted
  end
end
