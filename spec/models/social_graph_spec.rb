require 'spec_helper'

describe SocialGraph do
  before do
    mike = create_user(email: 'mike@example.com')
    @seth = create_user(email: 'seth@example.com')
    @graph = SocialGraph.new(mike)
  end

  it "creates pending friendships between users" do
    expect { @graph.add_friendship(@seth.id) }.to change { Friendship.all.length }.by(1)
    expect(@graph.friends_for).to match_array []
    last_friendship = Friendship.last
    expect(last_friendship.pending?).to eq true
  end

  it "should confirm pending friendships" do
    @graph.add_friendship(@seth.id)
    @graph.confirm_friendship(@seth.id)
    expect(@graph.friends_for).to match_array [@seth]
  end

  it "can tell if two users friendship is pending or not" do
    @graph.add_friendship(@seth.id)
    expect(@graph.friendship_pending?(@seth.id)).to eq true
    @graph.confirm_friendship(@seth.id)
    expect(@graph.friendship_pending?(@seth.id)).to eq false
  end

  it "friendships can only be created between users with id's" do
    expect(@graph.add_friendship(0)).to eq false
  end

  it "can tell if two people are friends" do
    expect(@graph.are_friends?(@seth.id)).to eq false
    @graph.add_friendship(@seth.id)
    expect(@graph.are_friends?(@seth.id)).to eq false
    @graph.confirm_friendship(@seth.id)
    expect(@graph.are_friends?(@seth.id)).to eq true
  end

  it "friendships between users can be removed" do
    expect(@graph.are_friends?(@seth.id)).to eq false
    @graph.add_friendship(@seth.id)
    @graph.confirm_friendship(@seth.id)
    expect(@graph.are_friends?(@seth.id)).to eq true
    @graph.remove_friendship(@seth.id)
    expect(@graph.are_friends?(@seth.id)).to eq false
  end

end