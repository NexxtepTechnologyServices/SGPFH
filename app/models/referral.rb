class Referral < ActiveRecord::Base
	has_many :ref_meds, dependent: :destroy
	has_many :notes, dependent: :destroy
	#has_and_belongs_to_many :ref_insuraces
	belongs_to :ref_pysician

	include Tire::Model::Search
    include Tire::Model::Callbacks

	#accepts_nested_attributes_for :ref_meds

	def name
		return "#{firstname} #{middlename} #{lastname}"
	end

end
