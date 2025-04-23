class AddDetailsToAdoptions < ActiveRecord::Migration[8.0]
  def change
    add_column :adoptions, :full_name, :string
    add_column :adoptions, :phone, :string
    add_column :adoptions, :email, :string
    add_column :adoptions, :reason, :text
  end
end
