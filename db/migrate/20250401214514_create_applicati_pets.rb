class CreateApplicatiPets < ActiveRecord::Migration[8.0]
  def change
    create_table :applicati_pets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pets, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
