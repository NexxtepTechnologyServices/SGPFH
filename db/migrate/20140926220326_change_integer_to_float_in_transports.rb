class ChangeIntegerToFloatInTransports < ActiveRecord::Migration
  def change
  	change_column :transports, :cost_per_mile, :decimal, :precision => 5, :scale => 3
  end
end
