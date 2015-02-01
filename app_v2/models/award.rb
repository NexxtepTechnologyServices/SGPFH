class Award < ActiveRecord::Base
	belongs_to :patient
	has_many :transports
	has_many :medications
	has_many :supplements
	has_many :devices

	after_save :update_patient_total
	#validate_presence_of :award_type, :total_requested

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
		fu and return if award_type.nil?
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

	def update_patient_total
		p = self.patient
		puts p.lifetime_total
		if total_requested.present?
			p.lifetime_total = p.lifetime_total + total_requested 
		else
			p.lifetime_total = total_requested
		end
		p.save
	end
end
