class AddCoordinatesToListings < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :latitude, :float
    add_column :listings, :longitude, :float
  end
end
