class Supplement < ActiveRecord::Base
	belongs_to :award

	def make(award,data)
		self.award_id = award.id
		#id_number = data.medication.id_number
		self.name = data['supplement']['name']
		self.unit_cost = data['supplement']['unit_cost']
		self.quantity = data['supplement']['quantity']
		self.total_cost = data['supplement']['total_cost']
	end
end
