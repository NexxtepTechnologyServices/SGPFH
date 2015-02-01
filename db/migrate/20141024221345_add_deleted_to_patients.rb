class AddDeletedToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :deleted, :datetime
  end
end
