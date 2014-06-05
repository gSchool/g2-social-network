require 'spec_helper'

describe Graph do
  it "creates pending friendships between users" do
    mike = create_user(email: 'mike@example.com')
    seth = create_user(email: 'seth@example.com')
    graph = Graph.new

    expect{graph.add_friendship(mike.id, seth.id)}.to change{Friendship.all.length}.by(1)
    expect(graph.friends_for(mike)).to match_array []
    last_friendship = Friendship.last
    expect(last_friendship.pending?).to eq true
  end

  it "should confirm pending friendships" do
    mike = create_user(email: 'mike@example.com')
    seth = create_user(email: 'seth@example.com')
    graph = Graph.new
    graph.add_friendship(mike.id, seth.id)
    graph.confirm_friendship(mike.id, seth.id)
    expect(graph.friends_for(mike)).to match_array [seth]
  end

  it "friendships can only be created between users with id's" do
    graph = Graph.new
    expect(graph.add_friendship(0, 0)).to eq false
  end

  it "can tell if two people are friends" do
    mike = create_user(email: 'mike@test.com')
    seth = create_user(email: 'seth@test.com')
    graph = Graph.new
    expect(graph.are_friends?(mike.id, seth.id)).to eq false
    graph.add_friendship(mike.id, seth.id)
    expect(graph.are_friends?(mike.id, seth.id)).to eq false
    graph.confirm_friendship(mike.id, seth.id)
    expect(graph.are_friends?(seth.id, mike.id)).to eq true
  end

  it "friendships between users can be removed" do
    mike = create_user(email: 'mike@test.com')
    seth = create_user(email: 'seth@test.com')
    graph = Graph.new
    expect(graph.are_friends?(mike.id, seth.id)).to eq false
    graph.add_friendship(mike.id, seth.id)
    graph.confirm_friendship(mike.id, seth.id)
    expect(graph.are_friends?(mike.id, seth.id)).to eq true
    graph.remove_friendship(mike.id, seth.id)
    expect(graph.are_friends?(mike.id, seth.id)).to eq false
  end

end