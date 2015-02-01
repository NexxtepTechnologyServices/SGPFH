ActiveAdmin.register Affiliate do

  permit_params do
    permitted = [:name, :email,:get_email,:created_at, :updated_at]
    permitted
  end
end
