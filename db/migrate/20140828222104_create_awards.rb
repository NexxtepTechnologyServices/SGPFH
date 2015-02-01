class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.integer :patient_id
      t.integer :award_type
      t.float :total_requested
      t.float :total_granted
      t.string :description

      t.timestamps
    end
  end
end
