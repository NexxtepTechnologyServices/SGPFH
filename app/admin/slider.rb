ActiveAdmin.register Slider do


  
  permit_params do
    permitted = [:image, :image_alt, :text1, :text2, :text3, :text4, :action, :controller]
    permitted
  end


end
