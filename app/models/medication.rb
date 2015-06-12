class Medication < ActiveRecord::Base
	include AwardsHelper
	
	belongs_to :award

	after_destroy :destroy_updates

	def make(award,data)
		self.award_id = award.id
		#id_number = data.medication.id_number
		self.name = data['medication']['name']
		self.unit_cost = data['medication']['unit_cost']
		self.quantity = data['medication']['quantity']
		self.total_cost = data['medication']['total_cost']
	end

	def destroy_updates
		update_patient_totals(self)
		remove_award_if_empty(self)
	end

end
