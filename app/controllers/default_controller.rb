class DefaultController < ApplicationController

	def index
		@sliders = Slider.where(action: 'index', controller: 'default')
	end
	def about
		@sliders = Slider.where(action: 'about', controller: 'default')
	end
	def pcf
		@sliders = Slider.where(action: 'pcf', controller: 'default')
	end
	def wellness
		@sliders = Slider.where(action: 'wellness', controller: 'default')
	end
	def healthcenter
		@sliders = Slider.where(action: 'healthcenter', controller: 'default')
	end
end