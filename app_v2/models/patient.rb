class Patient < ActiveRecord::Base
	has_many :awards

	validates_uniqueness_of :last_name, :scope => [:first_name, :middle_name, :birthday]

	include Tire::Model::Search
    include Tire::Model::Callbacks


	def name
		"#{first_name} #{last_name}"
	end

	def advocate_name
		"#{advocate_firstname} #{advocate_lastname}"
	end

	def funds_this_year
		qAwards = Award.where("created_at >= ? AND created_at < ? AND patient_id =?", Date.new(Time.now.year, 1, 1), Date.new(Time.now.year, 12, 31), id)
		total_awards = 0
		qAwards.each do |a| 
			total_awards = total_awards + a.funds_used
		end
		total_awards
	end

	def funds_this_quarter
		qAwards = nil
		case Time.now.month
		when 1..3
			qAwards = Award.where("created_at >= ? AND created_at < ? AND patient_id =?", Date.new(Time.now.year, 1, 1), Date.new(Time.now.year, 3, 31), id)
		when 4..6
			qAwards = Award.where("created_at >= ? AND created_at < ? AND patient_id =?", Date.new(Time.now.year, 4, 1), Date.new(Time.now.year, 6, 30), id)
		when 7..9
			qAwards = Award.where("created_at >= ? AND created_at < ? AND patient_id =?", Date.new(Time.now.year, 7, 1), Date.new(Time.now.year, 9, 30), id)
		when 10..12
			qAwards = Award.where("created_at >= ? AND created_at < ? AND patient_id =?", Date.new(Time.now.year, 10, 1), Date.new(Time.now.year, 12, 31), id)
		end
		total_awards = 0
		qAwards.each do |a| 
			total_awards = total_awards + a.funds_used
		end
		total_awards
	end

	def remaining_funds
		quarter_allowed = 500.0
		quarter_allowed - funds_this_quarter
	end

end
