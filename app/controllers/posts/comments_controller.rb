class Posts::CommentsController < ApplicationController

  def create
    @comment = PostComment.new(comment_params)
    if @comment.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:post_comment).permit([:content, :post_id])
  end
end
