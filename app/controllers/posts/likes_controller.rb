class Posts::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  def create
    unless liked?
      like = PostLike.new(post_id: @post.id)
      like.user = current_user
      if like.save
        redirect_to post_path(@post)
      end
    end
  end

  def destroy
    if liked?
      like = PostLike.find(params[:id])
      if like.destroy
        redirect_to post_path(@post)
      end
    end
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def liked?
    @post.likes.pluck(:user_id).include? current_user.id
  end

  # def find_like
  #   @like = @post.likes.select {|like| like == current_user.id }
  # end
end
