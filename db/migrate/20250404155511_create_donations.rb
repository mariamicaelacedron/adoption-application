class CreateDonations < ActiveRecord::Migration[8.0]
  def change
    create_table :donations do |t|
      t.references :user, foreign_key: true
      t.integer :donation_type
      t.decimal :amount
      t.text :description
      t.integer :status, default: 0
      
      t.timestamps
    end
  end
end