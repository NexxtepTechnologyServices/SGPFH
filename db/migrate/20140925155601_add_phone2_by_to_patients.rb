class AddPhone2ByToPatients < ActiveRecord::Migration
	def change	
		add_column :patients, :low_income, :integer
	    add_column :patients, :income_sources, :string
	    add_column :patients, :advocate_firstname, :string
	    add_column :patients, :advocate_lastname, :string
	    add_column :patients, :advocate_phone, :string
	    add_column :patients, :advocate_email, :string
	 end
end