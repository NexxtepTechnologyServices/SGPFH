class Medication < ActiveRecord::Base
	belongs_to :award

	def make(award,data)
		self.award_id = award.id
		#id_number = data.medication.id_number
		self.name = data['medication']['name']
		self.unit_cost = data['medication']['unit_cost']
		self.quantity = data['medication']['quantity']
		self.total_cost = data['medication']['total_cost']
	end
end
