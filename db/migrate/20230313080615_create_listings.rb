class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :description, null: false
      t.integer :price, null: false

      t.references :owner
      t.timestamps
    end

    add_foreign_key :listings, :users, column: :owner_id
  end
end
