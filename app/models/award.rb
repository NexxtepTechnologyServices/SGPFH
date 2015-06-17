class Award < ActiveRecord::Base
	belongs_to :patient, -> { unscope(where: :deleted) }
	has_many :transports, dependent: :destroy
	has_many :medications, dependent: :destroy
	has_many :supplements, dependent: :destroy
	has_many :devices, dependent: :destroy
	has_many :approvals, dependent: :destroy
	has_many :affiliates, through: :approvals
	has_many :comments, dependent: :destroy

	before_save :update_patient_total
	#validate_presence_of :award_type, :total_requested
	after_create :create_approvals

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

	def paid?
		funds_remaining == 0
	end

	def approved?
		a = self.approvals.reject { |ap| !ap.approval_method.nil?}
		a.empty?
		#affs = Affiliate.where(get_email: true)
		#a1 = affs.map { |a| a.id }
		#approved_affs = self.affiliates
		#a2 = approved_affs.map { |a| a.id }
		#(affs.sort == approved_affs.sort)
	end

	def approved_by?(affiliate)
		aa = approvals.where(affiliate_id: affiliate).first
		return false if aa.blank?
		!aa.approval_method.nil?
	end

	private

	def create_approvals
		affiliates = Affiliate.where(:get_email => true)
		affiliates.each do |a|
			approval = Approval.new
			approval.award = self
			approval.affiliate = a
			approval.approval_method = nil
			approval.save
		end
	end

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
		logger.info p.lifetime_total
		logger.info "#{total_requested} - #{total_granted}"
		d = total_granted - total_requested
		logger.info d
		if d != 0
			logger.info "d not 0"
			total_requested = total_granted
			p.lifetime_total += d
		else	
			logger.info "d is 0"
			p.lifetime_total = p.lifetime_total + total_granted 
		end
		logger.info p.lifetime_total
		p.save
	end
end
