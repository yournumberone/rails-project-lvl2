class Posts::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  def create
    unless liked?
      like = @post.likes.new(user_id: current_user.id)
      redirect_to post_path(@post), notice: 'Post Was Liked.' if like.save
    end
  end

  def destroy
    if liked?
      like = PostLike.find(params[:id])
      redirect_to post_path(@post), notice: 'Post Was Unliked.' if like.destroy
    end
  end

  def liked?
    @post.likes.pluck(:user_id).include? current_user.id
  end
end
