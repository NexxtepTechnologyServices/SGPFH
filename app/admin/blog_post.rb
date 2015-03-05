ActiveAdmin.register BlogPost do

  form(:html => { :multipart => true }) do |f|
    f.inputs "Post Details" do
      f.input :title
      f.input :author
      f.input :image, as: :file
      f.input :content, as: :html_editor
    end
    f.actions
  end



  permit_params do
    permitted = [:title, :author,:content,:image,:created_at, :updated_at]
    permitted
  end


end
