require 'spec_helper'

describe Post do

  describe 'post validations' do

    it 'the post cannot be blank' do
      post = create_post(post_body: "Here is a post")

      post.post_body = ""

      expect(post).to_not be_valid
    end
  end

  it "can find posts for a user and their friends" do
    mike = create_user(email: 'mike@example.com')
    seth = create_user(email: 'seth@example.com')
    graph = SocialGraph.new(mike)
    created_at = Time.now
    updated_at = Time.now

    other_user = create_user(email: 'be@be.com')
    graph.add_friendship(seth.id)
    graph.confirm_friendship(seth.id)
    create_post(other_user.id)
    post2 = create_post(mike.id, post_body: "I am Mike", created_at: created_at, updated_at: updated_at)
    post3 = create_post(seth.id, post_body: "I am Seth", created_at: created_at, updated_at: updated_at)

    expect(Post.posts_for(seth)).to eq [
                                            new_post(
                                              mike.id,
                                              id: post3.id,
                                              post_body: post3.post_body,
                                              created_at: created_at,
                                              updated_at: updated_at
                                            ),
                                            new_post(
                                              mike.id,
                                              id: post2.id,
                                              post_body: post2.post_body,
                                              created_at: created_at,
                                              updated_at: updated_at
                                            )
                                          ]

  end
end