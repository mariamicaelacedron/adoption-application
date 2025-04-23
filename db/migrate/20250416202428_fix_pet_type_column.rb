class FixPetTypeColumn < ActiveRecord::Migration[7.0]
  def change
    # 1. Cambiar a integer si no lo está
    change_column :pets, :pet_type, :integer, using: 'pet_type::integer'

    # 2. Establecer valor por defecto
    change_column_default :pets, :pet_type, from: nil, to: 3  # 3 = 'other'

    # 3. Hacer que la columna no acepte nulos
    change_column_null :pets, :pet_type, false
  end
end