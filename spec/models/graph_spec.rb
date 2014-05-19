require 'spec_helper'

describe Graph do
  it "creates friendships between users" do
    mike = User.create!(first_name: "Mike", last_name: "Killa", email: "kauf@kauf.com", password: "123456")
    seth = User.create!(first_name: "Seth", last_name: "Killa", email: "seth@kauf.com", password: "123456")
    graph = Graph.new

    expect{graph.add_friendship(mike.id, seth.id)}.to change{Friendship.all.length}.by(1)
    last_friendship = Friendship.last
    expect(last_friendship.user_id).to eq(mike.id)
    expect(last_friendship.friend_id).to eq(seth.id)

  end

  it "friendships can only be created between users with id's" do
    graph = Graph.new
    expect(graph.add_friendship(0, 0)).to eq false
  end

  it "can tell if two people are friends" do
    mike = User.create!(first_name: "Mike", last_name: "Killa", email: "kauf@kauf.com", password: "123456")
    seth = User.create!(first_name: "Seth", last_name: "Killa", email: "seth@kauf.com", password: "123456")
    graph = Graph.new
    expect(graph.are_friends?(mike.id, seth.id)).to eq false
    graph.add_friendship(mike.id, seth.id)
    expect(graph.are_friends?(mike.id, seth.id)).to eq true
    expect(graph.are_friends?(seth.id, mike.id)).to eq true
  end

end
