class CreateMedications < ActiveRecord::Migration
  def change
    create_table :medications do |t|
      t.integer :award_id
      t.string :id_number
      t.string :name
      t.float :unit_cost
      t.integer :quantity
      t.float :total_cost

      t.timestamps
    end
  end
end
