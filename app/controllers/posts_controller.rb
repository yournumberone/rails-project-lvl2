class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_post, only: %i[destroy show edit update]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
  end

  def show
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

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'Post was updated.'
    else
      flash[:alert] = 'Error on editing.'
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: 'Post was destroyed.'
    else
      redirect_to post_path(@post), alert: 'Oops'
    end
  end

  private

  def post_params
    params.require(:post).permit(%i[title body post_category_id])
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
