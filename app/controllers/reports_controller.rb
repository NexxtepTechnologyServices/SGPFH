class ReportsController < ApplicationController
  def index
  end

  def awards
  	@s = params[:start_date]
  	@e = params[:end_date]
  	@v = params.has_key?(:vendor) ? params[:vendor] : nil
  	@t = params.has_key?(:award_type) ? params[:award_type] : nil

  	conditions = ["date_of_service >= :s", "date_of_service <= :e"]
  	values = {s: @s, e: @e}
  	conditions << "vendor = :v" unless @v.blank?
  	values[:v] = @v unless @v.blank?
  	conditions << "award_type = :t" unless @t.nil? || @t.to_i == 0
  	values[:t] = @t unless @t.nil? || @t.to_i == 0
  	conditions_str = conditions.join(" AND ")
  	@awards = Award.where(conditions_str, values)
  	@sum = @awards.reduce(0) { |s,v| s += v.total_granted }
  end

  def patients
  	
  end

end
