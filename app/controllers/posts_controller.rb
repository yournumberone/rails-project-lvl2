# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @q = Post.includes(:creator, :post_category).ransack(params[:q])
    @posts = @q.result(distinct: true)
  end

  def show
    @post = find_post
    @comment = @post.comments.build
    @like = @post.likes.where(user_id: current_user.id).first if user_signed_in?
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post), notice: t('.success')
    else
      flash[:alert] = t('.error')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = find_post
    check_owner(@post)
  end

  def update
    @post = find_post
    check_owner(@post)
    if @post.update(post_params)
      redirect_to post_path(@post), notice: t('.success')
    else
      flash[:alert] = t('.error')
      render :edit
    end
  end

  def destroy
    @post = find_post
    check_owner(@post)
    if @post.destroy
      redirect_to posts_path, notice: t('.success')
    else
      redirect_to post_path(@post), alert: t('.error')
    end
  end

  private

  def post_params
    params.require(:post).permit(%i[title body post_category_id])
  end

  def find_post
    Post.find(params[:id])
  end

  def check_owner(post)
    redirect_to posts_path, alert: t('permission_denied') and return unless post.creator.id == current_user.id
  end
end
