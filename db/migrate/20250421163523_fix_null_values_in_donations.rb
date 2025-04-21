class FixNullValuesInDonations < ActiveRecord::Migration[7.0]
  def change
    change_column_null :donations, :donation_type, false, 'money'
    change_column_null :donations, :status, false, 'pending'
    change_column_null :donations, :payment_method, false, 'bank_transfer'
  end
end