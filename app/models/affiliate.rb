class Affiliate < ActiveRecord::Base
	has_many :approvals
	has_many :awards, through: :approvals
	before_save :create_slug
	private
	def create_slug
		Digest::MD5.hexdigest("#{id}#{email}")
	end
end