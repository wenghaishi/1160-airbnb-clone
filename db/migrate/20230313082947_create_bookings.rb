class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false
      t.references :listing, null: false
      t.integer :total, null: false

      t.timestamps
    end
  end
end
