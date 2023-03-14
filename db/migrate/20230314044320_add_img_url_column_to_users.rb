class AddImgUrlColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :img_url, :string
  end
end
