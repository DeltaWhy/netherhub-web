class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  has_many :friend_requests, ->(user) { unscope(where: :user_id).where("user_id = ? OR friend_id = ?", user.id, user.id).where(accepted: false) }, class_name: "Friendship"
  has_many :friendships, -> { where(accepted: true) }
  has_many :friends, through: :friendships, class_name: "User"
  validates :minecraft_username, presence: true

  def sent_friend_requests
    Friendship.where(user: self, accepted: false)
  end

  def received_friend_requests
    Friendship.where(friend: self, accepted: false)
  end

  def to_param
    minecraft_username
  end
end
