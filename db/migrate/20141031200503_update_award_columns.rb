class UpdateAwardColumns < ActiveRecord::Migration
  def change
  	add_column :awards, :date_of_service, :datetime
  end
end
