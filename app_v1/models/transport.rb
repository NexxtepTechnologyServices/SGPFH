class Transport < ActiveRecord::Base
	belongs_to :award

	def total_cost
		(number_of_miles * cost_per_mile) * (number_trips * 2)
	end
end
