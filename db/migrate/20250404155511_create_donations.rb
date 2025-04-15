class CreateDonations < ActiveRecord::Migration[8.0]
  def change
    create_table :donations do |t|
      t.references :user, null: false, foreign_key: true
      t.integer    :donation_type, null: false, default: 0
      t.decimal    :amount, null: false, precision: 10, scale: 2
      t.text       :description
      t.integer    :status, null: false, default: 0

      t.timestamps
    end
  end
end