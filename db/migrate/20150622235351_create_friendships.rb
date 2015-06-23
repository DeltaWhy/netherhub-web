class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :user_id, null: false, index: true
      t.integer :friend_id, null: false, index: true
      t.boolean :accepted, null: false, default: false
      t.datetime :accepted_at

      t.timestamps null: false
    end
  end
end
