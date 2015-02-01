class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.string :advocate_email
      t.integer :referring_physician_id
      t.string :prefix
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :home_phone
      t.string :work_phone
      t.string :contact_name
      t.string :contact_phone
      t.string :id_num
      t.datetime :date_of_birth
      t.string :gender
      t.string :married
      t.string :employed
      t.integer :citizen
      t.integer :household_size
      t.float :income
      t.string :income_sources

      t.timestamps
    end
  end
end
