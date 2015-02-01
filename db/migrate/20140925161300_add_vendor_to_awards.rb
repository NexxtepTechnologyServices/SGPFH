class AddVendorToAwards < ActiveRecord::Migration
	def change
    add_column :awards, :vendor, :string
  end
end