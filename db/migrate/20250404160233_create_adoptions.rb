class CreateAdoptions < ActiveRecord::Migration[8.0]
  def change
    create_table :adoptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pet, null: false, foreign_key: true
      t.integer :status, default: 0 
      t.text :answers

      t.timestamps
    end
    add_index :adoptions, [:user_id, :pet_id], unique: true
  end
end