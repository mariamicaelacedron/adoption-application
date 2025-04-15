class AddPaymentMethodToDonations < ActiveRecord::Migration[8.0]
  def change
    add_column :donations, :payment_method, :string
  end
end
