class Transport < ActiveRecord::Base
	belongs_to :award

	def total_cost
		(number_of_miles * cost_per_mile) * (number_trips * 2)
	end

	def make(award,data)
		self.award_id = award.id
		#id_number = data.medication.id_number
		self.number_of_miles = data['transport']['number_of_miles']
		self.cost_per_mile = data['transport']['cost_per_mile']
		self.number_trips = data['transport']['number_trips']
	end

end


 
 
 