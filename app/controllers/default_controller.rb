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

	def contact_us
		redirect_to "/", danger: "Message could not be sent." unless params[:human].blank?
		# Sends email to the user
		ContanctMailer.send_contact_info(params)
		# Sends email to Admin
		ContanctMailer.get_contact_info(params)
		redirect_to "/", notice: "Your message was sent successful."
	end
end