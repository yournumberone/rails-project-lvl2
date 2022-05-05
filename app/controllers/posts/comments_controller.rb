# frozen_string_literal: true

class Posts::CommentsController < Posts::ApplicationController
  before_action :authenticate_user!

  def create
    @post = find_post
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post), notice: t('.success')
    else
      redirect_to post_path(@post), alert: @comment.errors.first.full_message
    end
  end

  def destroy
    @comment = PostComment.find(params[:id])
    authorize @comment
    post = @comment.post
    if @comment.destroy
      redirect_to post_path(post), notice: t('.success')
    else
      redirect_to post_path(post), alert: @comment.errors.first.full_message
    end
  end

  private

  def comment_params
    params.require(:post_comment).permit(%i[content parent_id])
  end
end
