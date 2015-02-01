class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.integer :award_id
      t.string :name
      t.string :device_type
      t.float :unit_cost
      t.integer :quantity
      t.float :total_cost

      t.timestamps
    end
  end
end
