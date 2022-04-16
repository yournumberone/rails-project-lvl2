class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new()
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

  end

  private

  def post_params
    params.require(:post).permit([:title, :body, :post_category_id])
  end

end
