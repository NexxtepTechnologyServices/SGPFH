ActiveAdmin.register User do
permit_params do
  permitted = [:name, :email, :password, :password_confirmation, :affiliate_id, :role, :admin]
  permitted
end

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :role
    column "Affiliate" do |user|
    	user.affiliate.nil? ? "None Selected" : user.affiliate.name
    end
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "User Details" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.inputs "User Role" do
      f.input :role, as: :select, collection: [["Case Worker","case worker"], ["Reviewer", "reviewer"], ["Administrator", "administrator"]]
      #f.input :admin, as: :boolean, hint: "Please make sure this is check for an Administrative user"
    end

    f.inputs "If role is Affiliate, Selected an Affiliate account here" do
      f.input :affiliate_id, as: :select, collection: Affiliate.all.order("name asc").map { |a| [ a.name, a.id ] }
    end
    f.actions
  end

  #before_save do |user|
  #  !user.affiliate.nil?
  #end




#	form do |f|
#		f.inputs "Login Information" do
#			f.input :name
#			f.input :email
#			f.input :password
#			f.input :confirm_password
#			f.input :admin, as: :boolean
#			f.input :role, as: :select, collection: [["User","user"], ["Affliate", "affiliate"], ["Administrator", "administrator"]]
#		end
#		f.inputs "If role is Affiliate, Selected an Affiliate account here" do
#			f.input :affiliate_id, as: :select, collection: Affiliate.all.order("name asc").map { |a| [ a.name, a.id ] }
#		end
#		f.actions
#	end
#
#  permit_params do
#    permitted = [:name,:email,:admin,:role,:password,:confirm_password,:affiliate_id,:created_at, :updated_at]
#    permitted
#  end


end
