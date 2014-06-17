require 'spec_helper'

describe Post do

  describe 'post validations' do

    it 'the post cannot be blank' do
      post = create_post(post_body: "Here is a post")

      post.post_body = ""

      expect(post).to_not be_valid
    end
  end
end