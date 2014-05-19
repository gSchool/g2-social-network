require 'spec_helper'

describe Graph do
  it "creates friendships between users" do
    mike = User.create!(first_name: "Mike", last_name: "Killa", email: "kauf@kauf.com", password: "123456")
    seth = User.create!(first_name: "Seth", last_name: "Killa", email: "seth@kauf.com", password: "123456")
    graph = Graph.new

    expect{graph.add_friendship(mike.id, seth.id)}.to change{Friendship.all.length}.by(1)
    expect(Friendship.last.user_id).to eq(mike.id)
    expect(Friendship.last.friend_id).to eq(seth.id)

  end
end
