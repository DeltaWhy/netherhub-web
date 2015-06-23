class AddMinecraftToUsers < ActiveRecord::Migration
  def change
    add_column :users, :minecraft_username, :string, null: false
  end
end
