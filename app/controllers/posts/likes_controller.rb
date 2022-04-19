class Posts::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  def create
    return unless liked?

    like = @post.likes.new(user_id: current_user.id)
    redirect_to post_path(@post), notice: 'Post Was Liked.' if like.save
  end

  def destroy
    return if liked?

    like = PostLike.find(params[:id])
    redirect_to post_path(@post), notice: 'Post Was Unliked.' if like.destroy
  end

  def liked?
    @post.likes.pluck(:user_id).include? current_user.id
  end
end
