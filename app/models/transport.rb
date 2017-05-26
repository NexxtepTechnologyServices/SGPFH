class Transport < ActiveRecord::Base
	include AwardsHelper

	belongs_to :award


	after_destroy :destroy_updates

	def name
		"#{number_trips} x #{number_of_miles} trips"
	end

	def total_cost
		((number_of_miles * cost_per_mile) * (number_trips * 2)).round(2)
	end

	def quantity
		"NA"
	end

	def make(award,data)
		self.award_id = award.id
		#id_number = data.medication.id_number
		self.number_of_miles = data['transport']['number_of_miles'].empty? ? 0 : data['transport']['number_of_miles']
		self.cost_per_mile = data['transport']['cost_per_mile'].empty? ? 0 : data['transport']['cost_per_mile']
		self.number_trips = data['transport']['number_trips'].empty? ? 0 : data['transport']['number_trips']
	end

	def destroy_updates
		update_patient_totals(self)
		remove_award_if_empty(self)
	end
end


 
 
 