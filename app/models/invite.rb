class Invite < ActiveRecord::Base
  after_initialize :default_values
  validates :code, presence: true, uniqueness: true

  def default_values
    self.num_redemptions ||= 0
  end

  def can_redeem?
    return false if self.expires_at and self.expires_at < DateTime.now
    return false if self.num_uses and self.num_uses <= self.num_redemptions
    true
  end

  def redeem!
    self.num_redemptions += 1
    self.redeemed_at = DateTime.now
    save!
  end
end
