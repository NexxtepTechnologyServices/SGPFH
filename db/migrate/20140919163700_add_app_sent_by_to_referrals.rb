class AddAppSentByToReferrals < ActiveRecord::Migration
	def change
    add_column :referrals, :app_sent_by, :integer
  end
end