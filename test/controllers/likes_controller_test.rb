# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:one)
    sign_in @user
    @post_one = posts(:one)
    @post_two = posts(:two)
    @like = post_likes(:two)
  end

  test 'should like post' do
    post post_likes_path(@post_one)

    assert { PostComment.find_by! user_id: @user.id }

    assert_redirected_to post_url(@post_one)
  end

  test 'should destroy like' do
    delete post_like_path(@post_two, @like)

    assert { !PostLike.exists?(@like.id) }
    assert_redirected_to post_path(@post_two)
  end
end
