class CreateRefInsurances < ActiveRecord::Migration
  def change
    create_table :ref_insurances do |t|
      t.string :name

      t.timestamps
    end
  end
end
