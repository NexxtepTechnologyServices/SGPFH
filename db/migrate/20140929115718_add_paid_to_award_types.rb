class AddPaidToAwardTypes < ActiveRecord::Migration
  def change
  	add_column :transports, :paid, :boolean
  	add_column :medications, :paid, :boolean
  	add_column :supplements, :paid, :boolean
  	add_column :devices, :paid, :boolean
  end
end
