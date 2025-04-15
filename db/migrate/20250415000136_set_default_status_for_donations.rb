class SetDefaultStatusForDonations < ActiveRecord::Migration[8.0]
  def change
    change_column_default :donations, :status, 'pendiente'
  end
end