class Posts::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :owner?, only: :destroy

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post), notice: 'OMG! Who is this cool commentator here?'
    else
      redirect_to post_path(@post), alert: 'Oops'
    end
  end

  def destroy
    @comment = PostComment.find(params[:id])
    if @comment.destroy
      redirect_to post_path(@post), notice: 'Comment was destroyed.'
    else
      redirect_to post_path(@post), alert: 'Oops'
    end
  end

  private

  def comment_params
    params.require(:post_comment).permit(%i[content ancestry])
  end

  def owner?
    @comment = current_user.post_comments.find_by(id: params[:id])
    redirect_to post_path(@post), alert: 'You do not have permission to destroy this comment..' if @comment.nil?
  end
end
