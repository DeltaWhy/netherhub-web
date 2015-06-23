require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:alice) { User.create!(email: "alice@example.com", password: "password") }
  let(:bob) { User.create!(email: "bob@example.com", password: "password") }

  before do
    Friendship.destroy_all
  end

  it "requires user_id and friend_id" do
    expect(Friendship.new(user: nil, friend: bob)).to_not be_valid
    expect(Friendship.new(user: alice, friend: nil)).to_not be_valid
    expect(Friendship.new(user: alice, friend: bob)).to be_valid
  end

  context "when not accepted" do
    it "adds to friend_requests" do
      alice.friend_requests.create!(friend: bob)
      expect(alice.friend_requests).to_not be_empty
      expect(alice.sent_friend_requests).to_not be_empty
      expect(alice.received_friend_requests).to be_empty

      expect(bob.friend_requests).to_not be_empty
      expect(bob.sent_friend_requests).to be_empty
      expect(bob.received_friend_requests).to_not be_empty
    end

    it "does not add to friends" do
      alice.friend_requests.create!(friend: bob)
      expect(alice.friends).to be_empty
      expect(bob.friends).to be_empty
    end
  end

  context "when accepted" do
    it "is bidirectional" do
      alice.friend_requests.create!(friend: bob)
      bob.received_friend_requests.first.accept!

      expect(alice.friends.reload).to include(bob)
      expect(bob.friends).to include(alice)
    end

    it "is not in friend_requests" do
      alice.friend_requests.create!(friend: bob)
      bob.received_friend_requests.first.accept!

      expect(alice.friend_requests.reload).to be_empty
      expect(alice.sent_friend_requests).to be_empty
      expect(bob.friend_requests).to be_empty
      expect(bob.received_friend_requests).to be_empty
    end
  end
end
