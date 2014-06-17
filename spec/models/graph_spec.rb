require 'spec_helper'

describe Graph do
  before do
    @mike = create_user(email: 'mike@example.com')
    @seth = create_user(email: 'seth@example.com')
    @graph = Graph.new
  end

  it "creates pending friendships between users" do
    expect { @graph.add_friendship(@mike.id, @seth.id) }.to change { Friendship.all.length }.by(1)
    expect(@graph.friends_for(@mike)).to match_array []
    last_friendship = Friendship.last
    expect(last_friendship.pending?).to eq true
  end

  it "should confirm pending friendships" do
    @graph.add_friendship(@mike.id, @seth.id)
    @graph.confirm_friendship(@mike.id, @seth.id)
    expect(@graph.friends_for(@mike)).to match_array [@seth]
  end

  it "can tell if two users friendship is pending or not" do
    @graph.add_friendship(@mike.id, @seth.id)
    expect(@graph.friendship_pending?(@mike.id, @seth.id)).to eq true
    @graph.confirm_friendship(@mike.id, @seth.id)
    expect(@graph.friendship_pending?(@mike.id, @seth.id)).to eq false
  end

  it "friendships can only be created between users with id's" do
    expect(@graph.add_friendship(0, 0)).to eq false
  end

  it "can tell if two people are friends" do
    expect(@graph.are_friends?(@mike.id, @seth.id)).to eq false
    @graph.add_friendship(@mike.id, @seth.id)
    expect(@graph.are_friends?(@mike.id, @seth.id)).to eq false
    @graph.confirm_friendship(@mike.id, @seth.id)
    expect(@graph.are_friends?(@seth.id, @mike.id)).to eq true
  end

  it "friendships between users can be removed" do
    expect(@graph.are_friends?(@mike.id, @seth.id)).to eq false
    @graph.add_friendship(@mike.id, @seth.id)
    @graph.confirm_friendship(@mike.id, @seth.id)
    expect(@graph.are_friends?(@mike.id, @seth.id)).to eq true
    @graph.remove_friendship(@mike.id, @seth.id)
    expect(@graph.are_friends?(@mike.id, @seth.id)).to eq false
  end

  it "can find posts for a user and their friends" do
    created_at = Time.now
    updated_at = Time.now

    other_user = create_user(email: 'be@be.com')
    @graph.add_friendship(@mike.id, @seth.id)
    @graph.confirm_friendship(@mike.id, @seth.id)
    post1 = create_post(other_user.id)
    post2 = create_post(@mike.id, post_body: "I am Mike", created_at: created_at, updated_at: updated_at)
    post3 = create_post(@seth.id, post_body: "I am Seth", created_at: created_at, updated_at: updated_at)

    expect(@graph.posts_for(@seth)).to eq [
                                            new_post(
                                              @mike.id,
                                              id: post3.id,
                                              post_body: post3.post_body,
                                              created_at: created_at,
                                              updated_at: updated_at
                                            ),
                                            new_post(

                                              id: post2.id,
                                              post_body: post2.post_body,
                                              created_at: created_at,
                                              updated_at: updated_at
                                            )
                                          ]

  end

end