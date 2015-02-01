ActiveAdmin.register RefPysician do


  permit_params do
    permitted = [:name,:created_at, :updated_at]
    permitted
  end


end
