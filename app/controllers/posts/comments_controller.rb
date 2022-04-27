# frozen_string_literal: true

class Posts::CommentsController < Posts::ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: :create
  before_action :owner?, only: :destroy

  def create
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

  def owner?
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to posts_path, alert: t('permission_denied') if @comment.nil?
  end
end
