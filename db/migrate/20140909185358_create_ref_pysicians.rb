class CreateRefPysicians < ActiveRecord::Migration
  def change
    create_table :ref_pysicians do |t|
      t.string :name

      t.timestamps
    end
  end
end
