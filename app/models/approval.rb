class Approval < ActiveRecord::Base
	belongs_to :award
	belongs_to :affiliate

	validates_uniqueness_of :award_id, :scope => :affiliate_id

	scope :approved, -> { where.not( approval_method: nil ) } 
end