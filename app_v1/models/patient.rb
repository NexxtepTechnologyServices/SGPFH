class Patient < ActiveRecord::Base
	has_many :awards

	include Tire::Model::Search
    include Tire::Model::Callbacks


	def name
		"#{first_name} #{last_name}"
	end

	def advocate_name
		"#{advocate_firstname} #{advocate_lastname}"
	end
end
