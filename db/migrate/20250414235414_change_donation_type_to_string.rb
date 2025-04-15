class ChangeDonationTypeToString < ActiveRecord::Migration[8.0]
  def change
    change_column :donations, :donation_type, :string
  end
end