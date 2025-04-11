class AddDetailsToPets < ActiveRecord::Migration[8.0]
  def change
    add_column :pets, :pet_type, :integer, default: 0
    add_column :pets, :status, :integer, default: 0
    add_column :pets, :description, :text
    add_column :pets, :gender, :string
    add_column :pets, :size, :string
  end
end