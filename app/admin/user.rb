ActiveAdmin.register User do


  permit_params do
    permitted = [:name,:email,:admin,:role,:affiliate_id,:created_at, :updated_at]
    permitted
  end


end
