# frozen_string_literal: true

require 'test_helper'

class Posts::CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @comment = post_comments(:two)
    @post = posts(:two)
    sign_in users(:two)
    @attrs = {
      content: Faker::TvShows::FamilyGuy.quote,
      ancestry: post_comments(:two).id
    }
  end

  test 'should create comment' do
    post post_comments_path(@post), params: { post_comment: @attrs }

    assert { PostComment.find_by! content: @attrs[:content] }
    assert_redirected_to post_url(@post)
  end

  test 'should destroy comment' do
    post = @comment.post
    delete post_comment_path(post, @comment)

    assert { !PostComment.exists?(@comment.id) }
    assert_redirected_to post_path(post)
  end
end
