class Device < ActiveRecord::Base
	belongs_to :award

	def make(award,data)
		self.award_id = award.id
		#id_number = data.medication.id_number
		self.name = data['device']['name']
		self.device_type = data['device']['device_type']
		self.unit_cost = data['device']['unit_cost']
		self.quantity = data['device']['quantity']
		self.total_cost = data['device']['total_cost']
	end
end
