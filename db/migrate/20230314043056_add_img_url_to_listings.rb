class AddImgUrlToListings < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :img_url, :string
  end
end
