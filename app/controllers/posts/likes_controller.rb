# frozen_string_literal: true

class Posts::LikesController < Posts::ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  def create
    return if liked?

    like = @post.likes.new(user_id: current_user.id)
    redirect_to post_path(@post), notice: t('.success') if like.save
  end

  def destroy
    return unless liked?

    like = PostLike.find(params[:id])
    redirect_to post_path(@post), notice: t('.success') if like.destroy
  end

  def liked?
    @post.likes.pluck(:user_id).include? current_user.id
  end
end
