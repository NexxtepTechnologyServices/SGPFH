class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  before_filter :set_globals

  def format_dates(d)
      #Rails.logger.info("before: #{d}")
      #p = d.split("/")
      #Rails.logger.info("after: #{p[2]}-#{p[0]}-#{p[1]}")  
      #{}"#{p[2]}-#{p[0]}-#{p[1]}"
      d
  end

  private

  def set_globals
  	@isHomepage = params[:controller] == 'default' && params[:action] == 'index'
  	@milage_rate = 0.10
  end

end
