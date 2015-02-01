class FixAffiliateIdColumn < ActiveRecord::Migration
  def change
  	rename_column :approvals, :affilate_id, :affiliate_id
  end
end
