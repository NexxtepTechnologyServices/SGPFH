class CreateRefMeds < ActiveRecord::Migration
  def change
    create_table :ref_meds do |t|
      t.string :drug
      t.string :icd9
      t.string :diagnosis
      t.float :doscage
      t.string :sig
      t.string :dispense
      t.string :refills
      t.integer :referral_id

      t.timestamps
    end
  end
end
