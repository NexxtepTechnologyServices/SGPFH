class CreateAffiliates < ActiveRecord::Migration
  def change
    create_table :affiliates do |t|
      t.string :name
      t.string :email
      t.boolean :get_email
      t.timestamps
    end
  end
end
