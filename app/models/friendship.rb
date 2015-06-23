class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates_presence_of :user, :friend

  def accept!
    update_attributes!(accepted: true, accepted_at: DateTime.now)
    Friendship.find_or_initialize_by(user: self.friend, friend: self.user).update_attributes!(accepted: true, accepted_at: DateTime.now)
  end
end
