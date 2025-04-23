class ChangePetTypeAndStatusToString < ActiveRecord::Migration[7.0]
  def change
    change_column :pets, :pet_type, :string
    change_column :pets, :status, :string
  end
end