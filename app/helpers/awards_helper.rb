module AwardsHelper

	def update_patient_totals(item)
		p = item.award.patient
		award = item.award
		temp = award.total_granted
		award.total_granted -= item.total_cost.to_f
		award.save
	end

	def remove_award_if_empty(item) 
		return unless item.award.get_sub_awards.blank?
		item.award.delete
	end
end
