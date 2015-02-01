class AddPhoneByToPatients < ActiveRecord::Migration
	def change
    add_column :patients, :home_phone, :string
    add_column :patients, :work_phone, :string
    add_column :patients, :diagnosis, :string
    add_column :patients, :diagnosis_confirmed, :integer
    add_column :patients, :lifetime_total, :float
    add_column :patients, :year_total, :float
    add_column :patients, :quarter_total, :float
  end
end