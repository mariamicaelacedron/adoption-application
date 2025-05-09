class AddUserIdToDonations < ActiveRecord::Migration[8.0]
  def change
    add_reference :donations, :user, foreign_key: true
  end
end
