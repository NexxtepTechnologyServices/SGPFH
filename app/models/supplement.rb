class Supplement < ActiveRecord::Base
	include AwardsHelper
	
	belongs_to :award

	after_destroy :destroy_updates

	def make(award,data)
		self.award_id = award.id
		#id_number = data.medication.id_number
		self.name = data['supplement']['name'].empty? ? "None" : data['supplement']['name']
		self.unit_cost = data['supplement']['unit_cost'].empty? ? 0 : data['supplement']['unit_cost']
		self.quantity = data['supplement']['quantity'].empty? ? 0 : data['supplement']['quantity']
		self.total_cost = data['supplement']['total_cost'].empty? ? 0 : data['supplement']['total_cost']
	end

	def destroy_updates
		update_patient_totals(self)
		remove_award_if_empty(self)
	end

end
