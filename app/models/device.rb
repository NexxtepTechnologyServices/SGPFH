class Device < ActiveRecord::Base
	include AwardsHelper
	
	belongs_to :award

	after_destroy :destroy_updates

	def make(award,data)
		self.award_id = award.id
		#id_number = data.medication.id_number
		self.name = data['device']['name'].empty? ? "None" : data['device']['name']
		self.device_type = data['device']['device_type'].empty? ? "NA" : data['device']['device_type']
		self.unit_cost = data['device']['unit_cost'].empty? ? 0 : data['device']['unit_cost']
		self.quantity = data['device']['quantity'].empty? ? 0 : data['device']['quantity']
		self.total_cost = data['device']['total_cost'].empty? ? 0 : data['device']['total_cost']
	end

	def destroy_updates
		update_patient_totals(self)
		remove_award_if_empty(self)
	end

end
