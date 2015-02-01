class AddAppSentToReferrals < ActiveRecord::Migration
	def change
    add_column :referrals, :app_sent, :datetime
  end
end