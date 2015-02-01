class CreateApprovals < ActiveRecord::Migration
  def change
    create_table :approvals do |t|
      t.integer :affilate_id
      t.integer :award_id
      t.string :approval_method
      t.timestamps
    end
  end
end
