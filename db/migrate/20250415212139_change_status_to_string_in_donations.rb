class ChangeStatusToStringInDonations < ActiveRecord::Migration[8.0]
  def up
    # 1) convierte de integer a string, manteniendo los valores existentes
    change_column :donations, :status, :string, using: 'status::text'
    # 2) default correcto
    change_column_default :donations, :status, 'pendiente'
  end

  def down
    # para rollback: vuelve a integer
    change_column_default :donations, :status, 0
    change_column :donations, :status, :integer, using: 'status::integer'
  end
end
