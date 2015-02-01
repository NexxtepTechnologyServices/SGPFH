class CreateTransports < ActiveRecord::Migration
  def change
    create_table :transports do |t|
      t.integer :award_id
      t.integer :number_of_miles
      t.integer :cost_per_mile
      t.integer :number_trips

      t.timestamps
    end
  end
end
