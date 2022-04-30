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
      flash[:alert] = t('.error')
      render template: 'posts/show'
    end
  end

  def destroy
    @comment = PostComment.find(params[:id])
    check_owner(@comment)
    post = @comment.post
    if @comment.destroy
      redirect_to post_path(post), notice: t('.success')
    else
      flash[:alert] = t('.error')
      render template: 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:post_comment).permit(%i[content parent_id])
  end

  def check_owner(comment)
    redirect_to posts_path, alert: t('permission_denied') and return unless comment.user_id == current_user.id
  end
end
