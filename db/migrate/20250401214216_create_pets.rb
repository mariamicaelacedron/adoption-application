class CreatePets < ActiveRecord::Migration[8.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :breed
      t.integer :age

      t.timestamps
    end
  end
end
