class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :code, null: false, unique: true
      t.integer :user_id
      t.datetime :expires_at
      t.integer :num_uses
      t.integer :num_redemptions, null: false
      t.datetime :redeemed_at

      t.timestamps null: false
    end
  end
end
