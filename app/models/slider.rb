class Slider < ActiveRecord::Base
	mount_uploader :image, SliderImageUploader
end
