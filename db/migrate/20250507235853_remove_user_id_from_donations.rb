class RemoveUserIdFromDonations < ActiveRecord::Migration[8.0]
  def change
    remove_column :donations, :user_id, :integer
  end
end
