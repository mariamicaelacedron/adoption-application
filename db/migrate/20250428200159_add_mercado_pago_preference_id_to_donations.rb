class AddMercadoPagoPreferenceIdToDonations < ActiveRecord::Migration[8.0]
  def change
    add_column :donations, :mercado_pago_preference_id, :string
  end
end
