class Award < ActiveRecord::Base
	belongs_to :patient
	has_many :transports
	has_many :medications
	has_many :supplements
	has_many :devices


	def award_type_text
		t = ""
		case award_type
		when 1
			t = "Transportation"
		when 2
			t = "Medication"
		when 3
			t = "Medical Equipment"
		when 4
			t = "Nutritional Supplements"
		end
		t			
	end

	def funds_used
		fu = 0.0
		get_type_table.each do |t|
			fu = fu + t.total_cost if t.paid?
		end
		fu
	end

	def funds_remaining
		total_granted - funds_used
	end

	def get_sub_awards
		get_type_table
	end

	def get_sub_partial_name
		"at_#{award_type}"
	end

	private

	def get_type_table
		t = ""
		case award_type
		when 1
			t = self.transports
		when 2
			t = self.medications
		when 3
			t = self.devices
		when 4
			t = self.supplements
		end
		t	
	end
end
