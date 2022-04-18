class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.build
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    if @post.save
      redirect_to post_path(@post), notice: 'Post was successfully created'
    else
      flash[:alert] = 'Ooops'
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if post.destroy
      redirect_to posts_path, notice: 'Post was destroyed.'
    else
      redirect_to post_path(@post), alert: 'Oops'
    end
  end

  private

  def post_params
    params.require(:post).permit(%i[title body post_category_id])
  end
end
