require 'rails_helper'

RSpec.describe Invite, type: :model do
  it "requires code" do
    expect(Invite.new(code: "TESTCODE")).to be_valid
    expect(Invite.new).to_not be_valid
  end
  
  it "expires" do
    i = Invite.new(code: "EXPIRINGCODE", expires_at: 1.year.from_now)
    expect(i.can_redeem?).to be true
    i.expires_at = 1.day.ago
    expect(i.can_redeem?).to be false
  end

  context "when num_uses is nil" do
    it "can be redeemed" do
      i = Invite.new(code: "INFINITECODE", num_uses: nil)
      expect(i.can_redeem?).to be true
    end
  end

  context "when num_uses > 0" do
    it "can be redeemed a limited number of times" do
      i = Invite.create!(code: "ONEUSE", num_uses: 1)
      expect(i.can_redeem?).to be true
      i.redeem!
      expect(i.can_redeem?).to be false
    end
  end

  it "#redeem!" do
    i = Invite.create!(code: "REDEEM")
    expect(i.num_redemptions).to eq 0
    expect(i.redeemed_at).to be_nil
    i.redeem!
    expect(i.num_redemptions).to eq 1
    expect(i.redeemed_at).to_not be_nil
  end

  describe "#code" do
    it "is unique" do
      Invite.create!(code: "CONFLICT")
      expect(Invite.new(code: "CONFLICT")).to_not be_valid
    end
  end
end
