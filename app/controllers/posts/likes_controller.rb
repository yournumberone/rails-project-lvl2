# frozen_string_literal: true

class Posts::LikesController < Posts::ApplicationController
  before_action :authenticate_user!

  def create
    @post = find_post
    return if liked?

    like = @post.likes.new(user_id: current_user.id)
    redirect_to post_path(@post), notice: t('.success') if like.save
  end

  def destroy
    @post = find_post
    return unless liked?

    like = PostLike.find(params[:id])
    redirect_to post_path(@post), notice: t('.success') if like.destroy
  end

  def liked?
    @post.likes.pluck(:user_id).include? current_user.id
  end
end
