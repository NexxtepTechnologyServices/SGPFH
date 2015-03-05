class BlogPost < ActiveRecord::Base

	mount_uploader :image, BlogPostImageUploader

end
